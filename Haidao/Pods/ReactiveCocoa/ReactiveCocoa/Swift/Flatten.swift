//
//  Flatten.swift
//  ReactiveCocoa
//
//  Created by Neil Pankey on 11/30/15.
//  Copyright © 2015 GitHub. All rights reserved.
//

/// Describes how multiple producers should be joined together.
public enum FlattenStrategy: Equatable {
	/// The producers should be merged, so that any value received on any of the
	/// input producers will be forwarded immediately to the output producer.
	///
	/// The resulting producer will complete only when all inputs have completed.
	case merge

	/// The producers should be concatenated, so that their values are sent in the
	/// order of the producers themselves.
	///
	/// The resulting producer will complete only when all inputs have completed.
	case concat

	/// Only the events from the latest input producer should be considered for
	/// the output. Any producers received before that point will be disposed of.
	///
	/// The resulting producer will complete only when the producer-of-producers and
	/// the latest producer has completed.
	case latest
}


extension SignalType where Value: SignalProducerType, Error == Value.Error {
	/// Flattens the inner producers sent upon `signal` (into a single signal of
	/// values), according to the semantics of the given strategy.
	///
	/// If `signal` or an active inner producer fails, the returned signal will
	/// forward that failure immediately.
	///
	/// `Interrupted` events on inner producers will be treated like `Completed`
	/// events on inner producers.
	
	public func flatten(_ strategy: FlattenStrategy) -> Signal<Value.Value, Error> {
		switch strategy {
		case .merge:
			return self.merge()

		case .concat:
			return self.concat()

		case .latest:
			return self.switchToLatest()
		}
	}
}

extension SignalProducerType where Value: SignalProducerType, Error == Value.Error {
	/// Flattens the inner producers sent upon `producer` (into a single producer of
	/// values), according to the semantics of the given strategy.
	///
	/// If `producer` or an active inner producer fails, the returned producer will
	/// forward that failure immediately.
	///
	/// `Interrupted` events on inner producers will be treated like `Completed`
	/// events on inner producers.
	
	public func flatten(_ strategy: FlattenStrategy) -> SignalProducer<Value.Value, Error> {
		switch strategy {
		case .merge:
			return self.merge()

		case .concat:
			return self.concat()

		case .latest:
			return self.switchToLatest()
		}
	}
}

extension SignalType where Value: SignalType, Error == Value.Error {
	/// Flattens the inner signals sent upon `signal` (into a single signal of
	/// values), according to the semantics of the given strategy.
	///
	/// If `signal` or an active inner signal emits an error, the returned
	/// signal will forward that error immediately.
	///
	/// `Interrupted` events on inner signals will be treated like `Completed`
	/// events on inner signals.
	
	public func flatten(_ strategy: FlattenStrategy) -> Signal<Value.Value, Error> {
		return self.map(SignalProducer.init).flatten(strategy)
	}
}

extension SignalProducerType where Value: SignalType, Error == Value.Error {
	/// Flattens the inner signals sent upon `producer` (into a single producer of
	/// values), according to the semantics of the given strategy.
	///
	/// If `producer` or an active inner signal emits an error, the returned
	/// producer will forward that error immediately.
	///
	/// `Interrupted` events on inner signals will be treated like `Completed`
	/// events on inner signals.
	
	public func flatten(_ strategy: FlattenStrategy) -> SignalProducer<Value.Value, Error> {
		return self.map(SignalProducer.init).flatten(strategy)
	}
}


extension SignalType where Value: SignalProducerType, Error == Value.Error {
	/// Returns a signal which sends all the values from producer signal emitted from
	/// `signal`, waiting until each inner producer completes before beginning to
	/// send the values from the next inner producer.
	///
	/// If any of the inner producers fail, the returned signal will forward
	/// that failure immediately
	///
	/// The returned signal completes only when `signal` and all producers
	/// emitted from `signal` complete.
	fileprivate func concat() -> Signal<Value.Value, Error> {
		return Signal<Value.Value, Error> { relayObserver in
			let disposable = CompositeDisposable()
			let relayDisposable = CompositeDisposable()

			disposable += relayDisposable
			disposable += self.observeConcat(relayObserver, relayDisposable)

			return disposable
		}
	}

	fileprivate func observeConcat(_ observer: Observer<Value.Value, Error>, _ disposable: CompositeDisposable? = nil) -> Disposable? {
		let state = ConcatState(observer: observer, disposable: disposable)

		return self.observe { event in
			switch event {
			case let .next(value):
				state.enqueueSignalProducer(value.producer)

			case let .failed(error):
				observer.sendFailed(error)

			case .completed:
				// Add one last producer to the queue, whose sole job is to
				// "turn out the lights" by completing `observer`.
				state.enqueueSignalProducer(SignalProducer.empty.on(completed: {
					observer.sendCompleted()
				}))

			case .interrupted:
				observer.sendInterrupted()
			}
		}
	}
}

extension SignalProducerType where Value: SignalProducerType, Error == Value.Error {
	/// Returns a producer which sends all the values from each producer emitted from
	/// `producer`, waiting until each inner producer completes before beginning to
	/// send the values from the next inner producer.
	///
	/// If any of the inner producers emit an error, the returned producer will emit
	/// that error.
	///
	/// The returned producer completes only when `producer` and all producers
	/// emitted from `producer` complete.
	fileprivate func concat() -> SignalProducer<Value.Value, Error> {
		return SignalProducer<Value.Value, Error> { observer, disposable in
			self.startWithSignal { signal, signalDisposable in
				disposable += signalDisposable
				signal.observeConcat(observer, disposable)
			}
		}
	}
}

extension SignalProducerType {
	/// `concat`s `next` onto `self`.
	
	public func concat(_ next: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
		return SignalProducer<SignalProducer<Value, Error>, Error>(values: [self.producer, next]).flatten(.concat)
	}
}

private final class ConcatState<Value, Error: Error> {
	/// The observer of a started `concat` producer.
	let observer: Observer<Value, Error>

	/// The top level disposable of a started `concat` producer.
	let disposable: CompositeDisposable?

	/// The active producer, if any, and the producers waiting to be started.
	let queuedSignalProducers: Atomic<[SignalProducer<Value, Error>]> = Atomic([])

	init(observer: Signal<Value, Error>.Observer, disposable: CompositeDisposable?) {
		self.observer = observer
		self.disposable = disposable
	}

	func enqueueSignalProducer(_ producer: SignalProducer<Value, Error>) {
		if let d = disposable , d.disposed {
			return
		}

		var shouldStart = true

		queuedSignalProducers.modify {
			// An empty queue means the concat is idle, ready & waiting to start
			// the next producer.
			var queue = $0
			shouldStart = queue.isEmpty
			queue.append(producer)
			return queue
		}

		if shouldStart {
			startNextSignalProducer(producer)
		}
	}

	func dequeueSignalProducer() -> SignalProducer<Value, Error>? {
		if let d = disposable , d.disposed {
			return nil
		}

		var nextSignalProducer: SignalProducer<Value, Error>?

		queuedSignalProducers.modify {
			// Active producers remain in the queue until completed. Since
			// dequeueing happens at completion of the active producer, the
			// first producer in the queue can be removed.
			var queue = $0
			if !queue.isEmpty { queue.remove(at: 0) }
			nextSignalProducer = queue.first
			return queue
		}

		return nextSignalProducer
	}

	/// Subscribes to the given signal producer.
	func startNextSignalProducer(_ signalProducer: SignalProducer<Value, Error>) {
		signalProducer.startWithSignal { signal, disposable in
			let handle = self.disposable?.addDisposable(disposable) ?? nil

			signal.observe { event in
				switch event {
				case .completed, .interrupted:
					handle?.remove()

					if let nextSignalProducer = self.dequeueSignalProducer() {
						self.startNextSignalProducer(nextSignalProducer)
					}

				default:
					self.observer.action(event)
				}
			}
		}
	}
}

extension SignalType where Value: SignalProducerType, Error == Value.Error {
	/// Merges a `signal` of SignalProducers down into a single signal, biased toward the producer
	/// added earlier. Returns a Signal that will forward events from the inner producers as they arrive.
	fileprivate func merge() -> Signal<Value.Value, Error> {
		return Signal<Value.Value, Error> { relayObserver in
			let disposable = CompositeDisposable()
			let relayDisposable = CompositeDisposable()

			disposable += relayDisposable
			disposable += self.observeMerge(relayObserver, relayDisposable)

			return disposable
		}
	}

	fileprivate func observeMerge(_ observer: Observer<Value.Value, Error>, _ disposable: CompositeDisposable) -> Disposable? {
		let inFlight = Atomic(1)
		let decrementInFlight: () -> () = {
			let orig = inFlight.modify { $0 - 1 }
			if orig == 1 {
				observer.sendCompleted()
			}
		}

		return self.observe { event in
			switch event {
			case let .next(producer):
				producer.startWithSignal { innerSignal, innerDisposable in
					inFlight.modify { $0 + 1 }
					let handle = disposable.addDisposable(innerDisposable)

					innerSignal.observe { event in
						switch event {
						case .completed, .interrupted:
							handle.remove()
							decrementInFlight()

						default:
							observer.action(event)
						}
					}
				}

			case let .failed(error):
				observer.sendFailed(error)

			case .completed:
				decrementInFlight()

			case .interrupted:
				observer.sendInterrupted()
			}
		}
	}
}

extension SignalProducerType where Value: SignalProducerType, Error == Value.Error {
	/// Merges a `signal` of SignalProducers down into a single signal, biased toward the producer
	/// added earlier. Returns a Signal that will forward events from the inner producers as they arrive.
	fileprivate func merge() -> SignalProducer<Value.Value, Error> {
		return SignalProducer<Value.Value, Error> { relayObserver, disposable in
			self.startWithSignal { signal, signalDisposable in
				disposable.addDisposable(signalDisposable)

				signal.observeMerge(relayObserver, disposable)
			}

		}
	}
}

extension SignalType {
	/// Merges the given signals into a single `Signal` that will emit all values
	/// from each of them, and complete when all of them have completed.
	
	public static func merge<S: Sequence>(_ signals: S) -> Signal<Value, Error> where S.Iterator.Element == Signal<Value, Error> {
		let producer = SignalProducer<Signal<Value, Error>, Error>(values: signals)
		var result: Signal<Value, Error>!

		producer.startWithSignal { (signal, _) in
			result = signal.flatten(.merge)
		}

		return result
	}
}

extension SignalType where Value: SignalProducerType, Error == Value.Error {
	/// Returns a signal that forwards values from the latest signal sent on
	/// `signal`, ignoring values sent on previous inner signal.
	///
	/// An error sent on `signal` or the latest inner signal will be sent on the
	/// returned signal.
	///
	/// The returned signal completes when `signal` and the latest inner
	/// signal have both completed.
	fileprivate func switchToLatest() -> Signal<Value.Value, Error> {
		return Signal<Value.Value, Error> { observer in
			let composite = CompositeDisposable()
			let serial = SerialDisposable()

			composite += serial
			composite += self.observeSwitchToLatest(observer, serial)

			return composite
		}
	}

	fileprivate func observeSwitchToLatest(_ observer: Observer<Value.Value, Error>, _ latestInnerDisposable: SerialDisposable) -> Disposable? {
		let state = Atomic(LatestState<Value, Error>())

		return self.observe { event in
			switch event {
			case let .next(innerProducer):
				innerProducer.startWithSignal { innerSignal, innerDisposable in
					state.modify {
						// When we replace the disposable below, this prevents the
						// generated Interrupted event from doing any work.
						var state = $0
						state.replacingInnerSignal = true
						return state
					}

					latestInnerDisposable.innerDisposable = innerDisposable

					state.modify {
						var state = $0
						state.replacingInnerSignal = false
						state.innerSignalComplete = false
						return state
					}

					innerSignal.observe { event in
						switch event {
						case .interrupted:
							// If interruption occurred as a result of a new producer
							// arriving, we don't want to notify our observer.
							let original = state.modify {
								var state = $0
								if !state.replacingInnerSignal {
									state.innerSignalComplete = true
								}

								return state
							}

							if !original.replacingInnerSignal && original.outerSignalComplete {
								observer.sendCompleted()
							}

						case .completed:
							let original = state.modify {
								var state = $0
								state.innerSignalComplete = true
								return state
							}

							if original.outerSignalComplete {
								observer.sendCompleted()
							}

						default:
							observer.action(event)
						}
					}
				}
			case let .failed(error):
				observer.sendFailed(error)
			case .completed:
				let original = state.modify {
					var state = $0
					state.outerSignalComplete = true
					return state
				}

				if original.innerSignalComplete {
					observer.sendCompleted()
				}
			case .interrupted:
				observer.sendInterrupted()
			}
		}
	}
}

extension SignalProducerType where Value: SignalProducerType, Error == Value.Error {
	/// Returns a signal that forwards values from the latest signal sent on
	/// `signal`, ignoring values sent on previous inner signal.
	///
	/// An error sent on `signal` or the latest inner signal will be sent on the
	/// returned signal.
	///
	/// The returned signal completes when `signal` and the latest inner
	/// signal have both completed.
	fileprivate func switchToLatest() -> SignalProducer<Value.Value, Error> {
		return SignalProducer<Value.Value, Error> { observer, disposable in
			let latestInnerDisposable = SerialDisposable()
			disposable.addDisposable(latestInnerDisposable)

			self.startWithSignal { signal, signalDisposable in
				disposable += signalDisposable
				disposable += signal.observeSwitchToLatest(observer, latestInnerDisposable)
			}
		}
	}
}

private struct LatestState<Value, Error: Error> {
	var outerSignalComplete: Bool = false
	var innerSignalComplete: Bool = true
	
	var replacingInnerSignal: Bool = false
}


extension SignalType {
	/// Maps each event from `signal` to a new signal, then flattens the
	/// resulting producers (into a signal of values), according to the
	/// semantics of the given strategy.
	///
	/// If `signal` or any of the created producers fail, the returned signal
	/// will forward that failure immediately.
	
	public func flatMap<U>(_ strategy: FlattenStrategy, transform: (Value) -> SignalProducer<U, Error>) -> Signal<U, Error> {
		return map(transform).flatten(strategy)
	}

	/// Maps each event from `signal` to a new signal, then flattens the
	/// resulting signals (into a signal of values), according to the
	/// semantics of the given strategy.
	///
	/// If `signal` or any of the created signals emit an error, the returned
	/// signal will forward that error immediately.
	
	public func flatMap<U>(_ strategy: FlattenStrategy, transform: (Value) -> Signal<U, Error>) -> Signal<U, Error> {
		return map(transform).flatten(strategy)
	}
}

extension SignalProducerType {
	/// Maps each event from `self` to a new producer, then flattens the
	/// resulting producers (into a producer of values), according to the
	/// semantics of the given strategy.
	///
	/// If `self` or any of the created producers fail, the returned producer
	/// will forward that failure immediately.
	
	public func flatMap<U>(_ strategy: FlattenStrategy, transform: (Value) -> SignalProducer<U, Error>) -> SignalProducer<U, Error> {
		return map(transform).flatten(strategy)
	}

	/// Maps each event from `self` to a new producer, then flattens the
	/// resulting signals (into a producer of values), according to the
	/// semantics of the given strategy.
	///
	/// If `self` or any of the created signals emit an error, the returned
	/// producer will forward that error immediately.
	
	public func flatMap<U>(_ strategy: FlattenStrategy, transform: (Value) -> Signal<U, Error>) -> SignalProducer<U, Error> {
		return map(transform).flatten(strategy)
	}
}


extension SignalType {
	/// Catches any failure that may occur on the input signal, mapping to a new producer
	/// that starts in its place.
	
	public func flatMapError<F>(_ handler: (Error) -> SignalProducer<Value, F>) -> Signal<Value, F> {
		return Signal { observer in
			self.observeFlatMapError(handler, observer, SerialDisposable())
		}
	}

	fileprivate func observeFlatMapError<F>(_ handler: (Error) -> SignalProducer<Value, F>, _ observer: Observer<Value, F>, _ serialDisposable: SerialDisposable) -> Disposable? {
		return self.observe { event in
			switch event {
			case let .next(value):
				observer.sendNext(value)
			case let .failed(error):
				handler(error).startWithSignal { signal, disposable in
					serialDisposable.innerDisposable = disposable
					signal.observe(observer)
				}
			case .completed:
				observer.sendCompleted()
			case .interrupted:
				observer.sendInterrupted()
			}
		}
	}
}

extension SignalProducerType {
	/// Catches any failure that may occur on the input producer, mapping to a new producer
	/// that starts in its place.
	
	public func flatMapError<F>(_ handler: @escaping (Error) -> SignalProducer<Value, F>) -> SignalProducer<Value, F> {
		return SignalProducer { observer, disposable in
			let serialDisposable = SerialDisposable()
			disposable.addDisposable(serialDisposable)

			self.startWithSignal { signal, signalDisposable in
				serialDisposable.innerDisposable = signalDisposable

				signal.observeFlatMapError(handler, observer, serialDisposable)
			}
		}
	}
}
