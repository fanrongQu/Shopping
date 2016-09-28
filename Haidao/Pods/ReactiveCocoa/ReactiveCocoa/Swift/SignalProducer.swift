import Foundation
import Result

/// A SignalProducer creates Signals that can produce values of type `Value` and/or
/// fail with errors of type `Error`. If no failure should be possible, NoError
/// can be specified for `Error`.
///
/// SignalProducers can be used to represent operations or tasks, like network
/// requests, where each invocation of start() will create a new underlying
/// operation. This ensures that consumers will receive the results, versus a
/// plain Signal, where the results might be sent before any observers are
/// attached.
///
/// Because of the behavior of start(), different Signals created from the
/// producer may see a different version of Events. The Events may arrive in a
/// different order between Signals, or the stream might be completely
/// different!
public struct SignalProducer<Value, Error: Error> {
	public typealias ProducedSignal = Signal<Value, Error>

	fileprivate let startHandler: (Signal<Value, Error>.Observer, CompositeDisposable) -> ()

	/// Initializes a SignalProducer that will emit the same events as the given signal.
	///
	/// If the Disposable returned from start() is disposed or a terminating
	/// event is sent to the observer, the given signal will be
	/// disposed.
	public init<S: SignalType>(signal: S) where S.Value == Value, S.Error == Error {
		self.init { observer, disposable in
			disposable += signal.observe(observer)
		}
	}

	/// Initializes a SignalProducer that will invoke the given closure once
	/// for each invocation of start().
	///
	/// The events that the closure puts into the given observer will become
	/// the events sent by the started Signal to its observers.
	///
	/// If the Disposable returned from start() is disposed or a terminating
	/// event is sent to the observer, the given CompositeDisposable will be
	/// disposed, at which point work should be interrupted and any temporary
	/// resources cleaned up.
	public init(_ startHandler: @escaping (Signal<Value, Error>.Observer, CompositeDisposable) -> ()) {
		self.startHandler = startHandler
	}

	/// Creates a producer for a Signal that will immediately send one value
	/// then complete.
	public init(value: Value) {
		self.init { observer, disposable in
			observer.sendNext(value)
			observer.sendCompleted()
		}
	}

	/// Creates a producer for a Signal that will immediately fail with the
	/// given error.
	public init(error: Error) {
		self.init { observer, disposable in
			observer.sendFailed(error)
		}
	}

	/// Creates a producer for a Signal that will immediately send one value
	/// then complete, or immediately fail, depending on the given Result.
	public init(result: Result<Value, Error>) {
		switch result {
		case let .success(value):
			self.init(value: value)

		case let .failure(error):
			self.init(error: error)
		}
	}

	/// Creates a producer for a Signal that will immediately send the values
	/// from the given sequence, then complete.
	public init<S: Sequence>(values: S) where S.Iterator.Element == Value {
		self.init { observer, disposable in
			for value in values {
				observer.sendNext(value)

				if disposable.disposed {
					break
				}
			}

			observer.sendCompleted()
		}
	}

	/// A producer for a Signal that will immediately complete without sending
	/// any values.
	public static var empty: SignalProducer {
		return self.init { observer, disposable in
			observer.sendCompleted()
		}
	}

	/// A producer for a Signal that never sends any events to its observers.
	public static var never: SignalProducer {
		return self.init { _ in return }
	}

	/// Creates a queue for events that replays them when new signals are
	/// created from the returned producer.
	///
	/// When values are put into the returned observer (observer), they will be
	/// added to an internal buffer. If the buffer is already at capacity,
	/// the earliest (oldest) value will be dropped to make room for the new
	/// value.
	///
	/// Signals created from the returned producer will stay alive until a
	/// terminating event is added to the queue. If the queue does not contain
	/// such an event when the Signal is started, all values sent to the
	/// returned observer will be automatically forwarded to the Signal’s
	/// observers until a terminating event is received.
	///
	/// After a terminating event has been added to the queue, the observer
	/// will not add any further events. This _does not_ count against the
	/// value capacity so no buffered values will be dropped on termination.
	public static func buffer(_ capacity: Int) -> (SignalProducer, Signal<Value, Error>.Observer) {
		precondition(capacity >= 0, "Invalid capacity: \(capacity)")

		// This is effectively used as a synchronous mutex, but permitting
		// limited recursive locking (see below).
		//
		// The queue is a "variable" just so we can use its address as the key
		// and the value for dispatch_queue_set_specific().
		var queue = DispatchQueue(label: "org.reactivecocoa.ReactiveCocoa.SignalProducer.buffer", attributes: [])
		queue.setSpecific(key: /*Migrator FIXME: Use a variable of type DispatchSpecificKey*/ queue, value: &queue)

		// Used as an atomic variable so we can remove observers without needing
		// to run on the queue.
		let state: Atomic<BufferState<Value, Error>> = Atomic(BufferState())

		let producer = self.init { observer, disposable in
			// Assigned to when replay() is invoked synchronously below.
			var token: RemovalToken?

			let replay: () -> () = {
				let originalState = state.modify { state in
					var mutableState = state
					token = mutableState.observers?.insert(observer)
					return mutableState
				}

				originalState.values.forEach(observer.sendNext)

				if let terminationEvent = originalState.terminationEvent {
					observer.action(terminationEvent)
				}
			}

			// Prevent other threads from sending events while we're replaying,
			// but don't deadlock if we're replaying in response to a buffer
			// event observed elsewhere.
			//
			// In other words, this permits limited signal recursion for the
			// specific case of replaying past events.
			if DispatchQueue.getSpecific(&queue) != nil {
				replay()
			} else {
				queue.sync(execute: replay)
			}

			if let token = token {
				disposable.addDisposable {
					state.modify { state in
						var mutableState = state
						mutableState.observers?.removeValueForToken(token)
						return mutableState
					}
				}
			}
		}

		let bufferingObserver: Signal<Value, Error>.Observer = Observer { event in
			// Send serially with respect to other senders, and never while
			// another thread is in the process of replaying.
			queue.sync {
				let originalState = state.modify { state in
					var mutableState = state

					if let value = event.value {
						mutableState.addValue(value, upToCapacity: capacity)
					} else {
						// Disconnect all observers and prevent future
						// attachments.
						mutableState.terminationEvent = event
						mutableState.observers = nil
					}

					return mutableState
				}

				if let observers = originalState.observers {
					for observer in observers {
						observer.action(event)
					}
				}
			}
		}

		return (producer, bufferingObserver)
	}

	/// Creates a SignalProducer that will attempt the given operation once for
	/// each invocation of start().
	///
	/// Upon success, the started signal will send the resulting value then
	/// complete. Upon failure, the started signal will fail with the error that
	/// occurred.
	public static func attempt(_ operation: () -> Result<Value, Error>) -> SignalProducer {
		return self.init { observer, disposable in
			operation().analysis(ifSuccess: { value in
				observer.sendNext(value)
				observer.sendCompleted()
				}, ifFailure: { error in
					observer.sendFailed(error)
			})
		}
	}

	/// Creates a Signal from the producer, passes it into the given closure,
	/// then starts sending events on the Signal when the closure has returned.
	///
	/// The closure will also receive a disposable which can be used to
	/// interrupt the work associated with the signal and immediately send an
	/// `Interrupted` event.
	public func startWithSignal(_ setUp: @noescape (Signal<Value, Error>, Disposable) -> ()) {
		let (signal, observer) = Signal<Value, Error>.pipe()

		// Disposes of the work associated with the SignalProducer and any
		// upstream producers.
		let producerDisposable = CompositeDisposable()

		// Directly disposed of when start() or startWithSignal() is disposed.
		let cancelDisposable = ActionDisposable {
			observer.sendInterrupted()
			producerDisposable.dispose()
		}

		setUp(signal, cancelDisposable)

		if cancelDisposable.disposed {
			return
		}

		let wrapperObserver: Signal<Value, Error>.Observer = Observer { event in
			observer.action(event)

			if event.isTerminating {
				// Dispose only after notifying the Signal, so disposal
				// logic is consistently the last thing to run.
				producerDisposable.dispose()
			}
		}

		startHandler(wrapperObserver, producerDisposable)
	}
}

private struct BufferState<Value, Error: Error> {
	// All values in the buffer.
	var values: [Value] = []

	// Any terminating event sent to the buffer.
	//
	// This will be nil if termination has not occurred.
	var terminationEvent: Event<Value, Error>?

	// The observers currently attached to the buffered producer, or nil if the
	// producer was terminated.
	var observers: Bag<Signal<Value, Error>.Observer>? = Bag()

	// Appends a new value to the buffer, trimming it down to the given capacity
	// if necessary.
	mutating func addValue(_ value: Value, upToCapacity capacity: Int) {
		values.append(value)

		let overflow = values.count - capacity
		if overflow > 0 {
			values.removeSubrange(0..<overflow)
		}
	}
}

public protocol SignalProducerType {
	/// The type of values being sent on the producer
	associatedtype Value
	/// The type of error that can occur on the producer. If errors aren't possible
	/// then `NoError` can be used.
	associatedtype Error: Error

	/// Extracts a signal producer from the receiver.
	var producer: SignalProducer<Value, Error> { get }

	/// Creates a Signal from the producer, passes it into the given closure,
	/// then starts sending events on the Signal when the closure has returned.
	func startWithSignal(_ setUp: @noescape (Signal<Value, Error>, Disposable) -> ())
}

extension SignalProducer: SignalProducerType {
	public var producer: SignalProducer {
		return self
	}
}

extension SignalProducerType {
	/// Creates a Signal from the producer, then attaches the given observer to
	/// the Signal as an observer.
	///
	/// Returns a Disposable which can be used to interrupt the work associated
	/// with the signal and immediately send an `Interrupted` event.
	public func start(_ observer: Signal<Value, Error>.Observer = Signal<Value, Error>.Observer()) -> Disposable {
		var disposable: Disposable!

		startWithSignal { signal, innerDisposable in
			signal.observe(observer)
			disposable = innerDisposable
		}

		return disposable
	}

	/// Convenience override for start(_:) to allow trailing-closure style
	/// invocations.
	public func start(_ observerAction: Signal<Value, Error>.Observer.Action) -> Disposable {
		return start(Observer(observerAction))
	}

	/// Creates a Signal from the producer, then adds exactly one observer to
	/// the Signal, which will invoke the given callback when `next` events are
	/// received.
	///
	/// Returns a Disposable which can be used to interrupt the work associated
	/// with the Signal, and prevent any future callbacks from being invoked.
	public func startWithNext(_ next: @escaping (Value) -> ()) -> Disposable {
		return start(Observer(next: next))
	}

	/// Creates a Signal from the producer, then adds exactly one observer to
	/// the Signal, which will invoke the given callback when a `completed` event is
	/// received.
	///
	/// Returns a Disposable which can be used to interrupt the work associated
	/// with the Signal.
	public func startWithCompleted(_ completed: @escaping () -> ()) -> Disposable {
		return start(Observer(completed: completed))
	}
	
	/// Creates a Signal from the producer, then adds exactly one observer to
	/// the Signal, which will invoke the given callback when a `failed` event is
	/// received.
	///
	/// Returns a Disposable which can be used to interrupt the work associated
	/// with the Signal.
	public func startWithFailed(_ failed: @escaping (Error) -> ()) -> Disposable {
		return start(Observer(failed: failed))
	}
	
	/// Creates a Signal from the producer, then adds exactly one observer to
	/// the Signal, which will invoke the given callback when an `interrupted` event is
	/// received.
	///
	/// Returns a Disposable which can be used to interrupt the work associated
	/// with the Signal.
	public func startWithInterrupted(_ interrupted: @escaping () -> ()) -> Disposable {
		return start(Observer(interrupted: interrupted))
	}

	/// Lifts an unary Signal operator to operate upon SignalProducers instead.
	///
	/// In other words, this will create a new SignalProducer which will apply
	/// the given Signal operator to _every_ created Signal, just as if the
	/// operator had been applied to each Signal yielded from start().
	
	public func lift<U, F>(_ transform: (Signal<Value, Error>) -> Signal<U, F>) -> SignalProducer<U, F> {
		return SignalProducer { observer, outerDisposable in
			self.startWithSignal { signal, innerDisposable in
				outerDisposable.addDisposable(innerDisposable)

				transform(signal).observe(observer)
			}
		}
	}

	/// Lifts a binary Signal operator to operate upon SignalProducers instead.
	///
	/// In other words, this will create a new SignalProducer which will apply
	/// the given Signal operator to _every_ Signal created from the two
	/// producers, just as if the operator had been applied to each Signal
	/// yielded from start().
	///
	/// Note: starting the returned producer will start the receiver of the operator,
	/// which may not be adviseable for some operators.
	
	public func lift<U, F, V, G>(_ transform: (Signal<Value, Error>) -> (Signal<U, F>) -> Signal<V, G>) -> (SignalProducer<U, F>) -> SignalProducer<V, G> {
		return liftRight(transform)
	}

	/// Right-associative lifting of a binary signal operator over producers. That
	/// is, the argument producer will be started before the receiver. When both
	/// producers are synchronous this order can be important depending on the operator
	/// to generate correct results.
	
	fileprivate func liftRight<U, F, V, G>(_ transform: @escaping (Signal<Value, Error>) -> (Signal<U, F>) -> Signal<V, G>) -> (SignalProducer<U, F>) -> SignalProducer<V, G> {
		return { otherProducer in
			return SignalProducer { observer, outerDisposable in
				self.startWithSignal { signal, disposable in
					outerDisposable.addDisposable(disposable)

					otherProducer.startWithSignal { otherSignal, otherDisposable in
						outerDisposable.addDisposable(otherDisposable)

						transform(signal)(otherSignal).observe(observer)
					}
				}
			}
		}
	}

	/// Left-associative lifting of a binary signal operator over producers. That
	/// is, the receiver will be started before the argument producer. When both
	/// producers are synchronous this order can be important depending on the operator
	/// to generate correct results.
	
	fileprivate func liftLeft<U, F, V, G>(_ transform: @escaping (Signal<Value, Error>) -> (Signal<U, F>) -> Signal<V, G>) -> (SignalProducer<U, F>) -> SignalProducer<V, G> {
		return { otherProducer in
			return SignalProducer { observer, outerDisposable in
				otherProducer.startWithSignal { otherSignal, otherDisposable in
					outerDisposable.addDisposable(otherDisposable)
					
					self.startWithSignal { signal, disposable in
						outerDisposable.addDisposable(disposable)

						transform(signal)(otherSignal).observe(observer)
					}
				}
			}
		}
	}

	/// Lifts a binary Signal operator to operate upon a Signal and a SignalProducer instead.
	///
	/// In other words, this will create a new SignalProducer which will apply
	/// the given Signal operator to _every_ Signal created from the two
	/// producers, just as if the operator had been applied to each Signal
	/// yielded from start().
	
	public func lift<U, F, V, G>(_ transform: @escaping (Signal<Value, Error>) -> (Signal<U, F>) -> Signal<V, G>) -> (Signal<U, F>) -> SignalProducer<V, G> {
		return { otherSignal in
			return SignalProducer { observer, outerDisposable in
				self.startWithSignal { signal, disposable in
					outerDisposable += disposable
					outerDisposable += transform(signal)(otherSignal).observe(observer)
				}
			}
		}
	}
	
	/// Maps each value in the producer to a new value.
	
	public func map<U>(_ transform: @escaping (Value) -> U) -> SignalProducer<U, Error> {
		return lift { $0.map(transform) }
	}

	/// Maps errors in the producer to a new error.
	
	public func mapError<F>(_ transform: @escaping (Error) -> F) -> SignalProducer<Value, F> {
		return lift { $0.mapError(transform) }
	}

	/// Preserves only the values of the producer that pass the given predicate.
	
	public func filter(_ predicate: @escaping (Value) -> Bool) -> SignalProducer<Value, Error> {
		return lift { $0.filter(predicate) }
	}

	/// Returns a producer that will yield the first `count` values from the
	/// input producer.
	
	public func take(_ count: Int) -> SignalProducer<Value, Error> {
		return lift { $0.take(count) }
	}

	/// Returns a signal that will yield an array of values when `signal` completes.
	
	public func collect() -> SignalProducer<[Value], Error> {
		return lift { $0.collect() }
	}

	/// Forwards all events onto the given scheduler, instead of whichever
	/// scheduler they originally arrived upon.
	
	public func observeOn(_ scheduler: SchedulerType) -> SignalProducer<Value, Error> {
		return lift { $0.observeOn(scheduler) }
	}

	/// Combines the latest value of the receiver with the latest value from
	/// the given producer.
	///
	/// The returned producer will not send a value until both inputs have sent at
	/// least one value each. If either producer is interrupted, the returned producer
	/// will also be interrupted.
	
	public func combineLatestWith<U>(_ otherProducer: SignalProducer<U, Error>) -> SignalProducer<(Value, U), Error> {
		// This should be the implementation of this method:
		// return liftRight(Signal.combineLatestWith)(otherProducer)
		//
		// However, due to a Swift miscompilation (with `-O`) we need to inline `liftRight` here.
		// See https://github.com/ReactiveCocoa/ReactiveCocoa/issues/2751 for more details.
		//
		// This can be reverted once tests with -O don't crash. 

		return SignalProducer { observer, outerDisposable in
			self.startWithSignal { signal, disposable in
				outerDisposable.addDisposable(disposable)

				otherProducer.startWithSignal { otherSignal, otherDisposable in
					outerDisposable.addDisposable(otherDisposable)

					signal.combineLatestWith(otherSignal).observe(observer)
				}
			}
		}
	}

	/// Combines the latest value of the receiver with the latest value from
	/// the given signal.
	///
	/// The returned producer will not send a value until both inputs have sent at
	/// least one value each. If either input is interrupted, the returned producer
	/// will also be interrupted.
	
	public func combineLatestWith<U>(_ otherSignal: Signal<U, Error>) -> SignalProducer<(Value, U), Error> {
		return lift(Signal.combineLatestWith)(otherSignal)
	}

	/// Delays `Next` and `Completed` events by the given interval, forwarding
	/// them on the given scheduler.
	///
	/// `Failed` and `Interrupted` events are always scheduled immediately.
	
	public func delay(_ interval: TimeInterval, onScheduler scheduler: DateSchedulerType) -> SignalProducer<Value, Error> {
		return lift { $0.delay(interval, onScheduler: scheduler) }
	}

	/// Returns a producer that will skip the first `count` values, then forward
	/// everything afterward.
	
	public func skip(_ count: Int) -> SignalProducer<Value, Error> {
		return lift { $0.skip(count) }
	}

	/// Treats all Events from the input producer as plain values, allowing them to be
	/// manipulated just like any other value.
	///
	/// In other words, this brings Events “into the monad.”
	///
	/// When a Completed or Failed event is received, the resulting producer will send
	/// the Event itself and then complete. When an Interrupted event is received,
	/// the resulting producer will send the Event itself and then interrupt.
	
	public func materialize() -> SignalProducer<Event<Value, Error>, NoError> {
		return lift { $0.materialize() }
	}

	/// Forwards the latest value from `self` whenever `sampler` sends a Next
	/// event.
	///
	/// If `sampler` fires before a value has been observed on `self`, nothing
	/// happens.
	///
	/// Returns a producer that will send values from `self`, sampled (possibly
	/// multiple times) by `sampler`, then complete once both input producers have
	/// completed, or interrupt if either input producer is interrupted.
	
	public func sampleOn(_ sampler: SignalProducer<(), NoError>) -> SignalProducer<Value, Error> {
		return liftLeft(Signal.sampleOn)(sampler)
	}

	/// Forwards the latest value from `self` whenever `sampler` sends a Next
	/// event.
	///
	/// If `sampler` fires before a value has been observed on `self`, nothing
	/// happens.
	///
	/// Returns a producer that will send values from `self`, sampled (possibly
	/// multiple times) by `sampler`, then complete once both inputs have
	/// completed, or interrupt if either input is interrupted.
	
	public func sampleOn(_ sampler: Signal<(), NoError>) -> SignalProducer<Value, Error> {
		return lift(Signal.sampleOn)(sampler)
	}

	/// Forwards events from `self` until `trigger` sends a Next or Completed
	/// event, at which point the returned producer will complete.
	
	public func takeUntil(_ trigger: SignalProducer<(), NoError>) -> SignalProducer<Value, Error> {
		return liftRight(Signal.takeUntil)(trigger)
	}

	/// Forwards events from `self` until `trigger` sends a Next or Completed
	/// event, at which point the returned producer will complete.
	
	public func takeUntil(_ trigger: Signal<(), NoError>) -> SignalProducer<Value, Error> {
		return lift(Signal.takeUntil)(trigger)
	}

	/// Does not forward any values from `self` until `trigger` sends a Next or
	/// Completed, at which point the returned signal behaves exactly like `signal`.
	
	public func skipUntil(_ trigger: SignalProducer<(), NoError>) -> SignalProducer<Value, Error> {
		return liftRight(Signal.skipUntil)(trigger)
	}
	
	/// Does not forward any values from `self` until `trigger` sends a Next or
	/// Completed, at which point the returned signal behaves exactly like `signal`.
	
	public func skipUntil(_ trigger: Signal<(), NoError>) -> SignalProducer<Value, Error> {
		return lift(Signal.skipUntil)(trigger)
	}
	
	/// Forwards events from `self` with history: values of the returned producer
	/// are a tuple whose first member is the previous value and whose second member
	/// is the current value. `initial` is supplied as the first member when `self`
	/// sends its first value.
	
	public func combinePrevious(_ initial: Value) -> SignalProducer<(Value, Value), Error> {
		return lift { $0.combinePrevious(initial) }
	}

	/// Like `scan`, but sends only the final value and then immediately completes.
	
	public func reduce<U>(_ initial: U, _ combine: @escaping (U, Value) -> U) -> SignalProducer<U, Error> {
		return lift { $0.reduce(initial, combine) }
	}

	/// Aggregates `self`'s values into a single combined value. When `self` emits
	/// its first value, `combine` is invoked with `initial` as the first argument and
	/// that emitted value as the second argument. The result is emitted from the
	/// producer returned from `scan`. That result is then passed to `combine` as the
	/// first argument when the next value is emitted, and so on.
	
	public func scan<U>(_ initial: U, _ combine: @escaping (U, Value) -> U) -> SignalProducer<U, Error> {
		return lift { $0.scan(initial, combine) }
	}

	/// Forwards only those values from `self` which do not pass `isRepeat` with
	/// respect to the previous value. The first value is always forwarded.
	
	public func skipRepeats(_ isRepeat: @escaping (Value, Value) -> Bool) -> SignalProducer<Value, Error> {
		return lift { $0.skipRepeats(isRepeat) }
	}

	/// Does not forward any values from `self` until `predicate` returns false,
	/// at which point the returned signal behaves exactly like `self`.
	
	public func skipWhile(_ predicate: @escaping (Value) -> Bool) -> SignalProducer<Value, Error> {
		return lift { $0.skipWhile(predicate) }
	}

	/// Forwards events from `self` until `replacement` begins sending events.
	///
	/// Returns a producer which passes through `Next`, `Failed`, and `Interrupted`
	/// events from `self` until `replacement` sends an event, at which point the
	/// returned producer will send that event and switch to passing through events
	/// from `replacement` instead, regardless of whether `self` has sent events
	/// already.
	
	public func takeUntilReplacement(_ replacement: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
		return liftRight(Signal.takeUntilReplacement)(replacement)
	}

	/// Forwards events from `self` until `replacement` begins sending events.
	///
	/// Returns a producer which passes through `Next`, `Error`, and `Interrupted`
	/// events from `self` until `replacement` sends an event, at which point the
	/// returned producer will send that event and switch to passing through events
	/// from `replacement` instead, regardless of whether `self` has sent events
	/// already.
	
	public func takeUntilReplacement(_ replacement: Signal<Value, Error>) -> SignalProducer<Value, Error> {
		return lift(Signal.takeUntilReplacement)(replacement)
	}

	/// Waits until `self` completes and then forwards the final `count` values
	/// on the returned producer.
	
	public func takeLast(_ count: Int) -> SignalProducer<Value, Error> {
		return lift { $0.takeLast(count) }
	}

	/// Forwards any values from `self` until `predicate` returns false,
	/// at which point the returned producer will complete.
	
	public func takeWhile(_ predicate: @escaping (Value) -> Bool) -> SignalProducer<Value, Error> {
		return lift { $0.takeWhile(predicate) }
	}

	/// Zips elements of two producers into pairs. The elements of any Nth pair
	/// are the Nth elements of the two input producers.
	
	public func zipWith<U>(_ otherProducer: SignalProducer<U, Error>) -> SignalProducer<(Value, U), Error> {
		return liftRight(Signal.zipWith)(otherProducer)
	}

	/// Zips elements of this producer and a signal into pairs. The elements of 
	/// any Nth pair are the Nth elements of the two.
	
	public func zipWith<U>(_ otherSignal: Signal<U, Error>) -> SignalProducer<(Value, U), Error> {
		return lift(Signal.zipWith)(otherSignal)
	}

	/// Applies `operation` to values from `self` with `Success`ful results
	/// forwarded on the returned producer and `Failure`s sent as `Failed` events.
	
	public func attempt(_ operation: (Value) -> Result<(), Error>) -> SignalProducer<Value, Error> {
		return lift { $0.attempt(operation) }
	}

	/// Applies `operation` to values from `self` with `Success`ful results mapped
	/// on the returned producer and `Failure`s sent as `Failed` events.
	
	public func attemptMap<U>(_ operation: (Value) -> Result<U, Error>) -> SignalProducer<U, Error> {
		return lift { $0.attemptMap(operation) }
	}

	/// Throttle values sent by the receiver, so that at least `interval`
	/// seconds pass between each, then forwards them on the given scheduler.
	///
	/// If multiple values are received before the interval has elapsed, the
	/// latest value is the one that will be passed on.
	///
	/// If `self` terminates while a value is being throttled, that value
	/// will be discarded and the returned producer will terminate immediately.
	
	public func throttle(_ interval: TimeInterval, onScheduler scheduler: DateSchedulerType) -> SignalProducer<Value, Error> {
		return lift { $0.throttle(interval, onScheduler: scheduler) }
	}

	/// Forwards events from `self` until `interval`. Then if producer isn't completed yet,
	/// fails with `error` on `scheduler`.
	///
	/// If the interval is 0, the timeout will be scheduled immediately. The producer
	/// must complete synchronously (or on a faster scheduler) to avoid the timeout.
	
	public func timeoutWithError(_ error: Error, afterInterval interval: TimeInterval, onScheduler scheduler: DateSchedulerType) -> SignalProducer<Value, Error> {
		return lift { $0.timeoutWithError(error, afterInterval: interval, onScheduler: scheduler) }
	}
}

extension SignalProducerType where Value: OptionalType {
	/// Unwraps non-`nil` values and forwards them on the returned signal, `nil`
	/// values are dropped.
	
	public func ignoreNil() -> SignalProducer<Value.Wrapped, Error> {
		return lift { $0.ignoreNil() }
	}
}

extension SignalProducerType where Value: EventType, Error == NoError {
	/// The inverse of materialize(), this will translate a signal of `Event`
	/// _values_ into a signal of those events themselves.
	
	public func dematerialize() -> SignalProducer<Value.Value, Value.Error> {
		return lift { $0.dematerialize() }
	}
}

extension SignalProducerType where Error == NoError {
	/// Promotes a producer that does not generate failures into one that can.
	///
	/// This does not actually cause failers to be generated for the given producer,
	/// but makes it easier to combine with other producers that may fail; for
	/// example, with operators like `combineLatestWith`, `zipWith`, `flatten`, etc.
	
	public func promoteErrors<F: Error>(_: F.Type) -> SignalProducer<Value, F> {
		return lift { $0.promoteErrors(F) }
	}
}

extension SignalProducerType where Value: Equatable {
	/// Forwards only those values from `self` which are not duplicates of the
	/// immedately preceding value. The first value is always forwarded.
	
	public func skipRepeats() -> SignalProducer<Value, Error> {
		return lift { $0.skipRepeats() }
	}
}


/// Creates a repeating timer of the given interval, with a reasonable
/// default leeway, sending updates on the given scheduler.
///
/// This timer will never complete naturally, so all invocations of start() must
/// be disposed to avoid leaks.

public func timer(_ interval: TimeInterval, onScheduler scheduler: DateSchedulerType) -> SignalProducer<Date, NoError> {
	// Apple's "Power Efficiency Guide for Mac Apps" recommends a leeway of
	// at least 10% of the timer interval.
	return timer(interval, onScheduler: scheduler, withLeeway: interval * 0.1)
}

/// Creates a repeating timer of the given interval, sending updates on the
/// given scheduler.
///
/// This timer will never complete naturally, so all invocations of start() must
/// be disposed to avoid leaks.

public func timer(_ interval: TimeInterval, onScheduler scheduler: DateSchedulerType, withLeeway leeway: TimeInterval) -> SignalProducer<Date, NoError> {
	precondition(interval >= 0)
	precondition(leeway >= 0)

	return SignalProducer { observer, compositeDisposable in
		compositeDisposable += scheduler.scheduleAfter(scheduler.currentDate.addingTimeInterval(interval), repeatingEvery: interval, withLeeway: leeway) {
			observer.sendNext(scheduler.currentDate)
		}
	}
}

extension SignalProducerType {
	/// Injects side effects to be performed upon the specified signal events.
	
	public func on(started: (() -> ())? = nil, event: ((Event<Value, Error>) -> ())? = nil, failed: ((Error) -> ())? = nil, completed: (() -> ())? = nil, interrupted: (() -> ())? = nil, terminated: (() -> ())? = nil, disposed: (() -> ())? = nil, next: ((Value) -> ())? = nil) -> SignalProducer<Value, Error> {
		return SignalProducer { observer, compositeDisposable in
			started?()
			self.startWithSignal { signal, disposable in
				compositeDisposable += disposable
				compositeDisposable += signal
					.on(
						event: event,
						failed: failed,
						completed: completed,
						interrupted: interrupted,
						terminated: terminated,
						disposed: disposed,
						next: next
					)
					.observe(observer)
			}
		}
	}

	/// Starts the returned signal on the given Scheduler.
	///
	/// This implies that any side effects embedded in the producer will be
	/// performed on the given scheduler as well.
	///
	/// Events may still be sent upon other schedulers—this merely affects where
	/// the `start()` method is run.
	
	public func startOn(_ scheduler: SchedulerType) -> SignalProducer<Value, Error> {
		return SignalProducer { observer, compositeDisposable in
			compositeDisposable += scheduler.schedule {
				self.startWithSignal { signal, signalDisposable in
					compositeDisposable.addDisposable(signalDisposable)
					signal.observe(observer)
				}
			}
		}
	}
}

/// Combines the values of all the given producers, in the manner described by
/// `combineLatestWith`.

public func combineLatest<A, B, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>) -> SignalProducer<(A, B), Error> {
	return a.combineLatestWith(b)
}

/// Combines the values of all the given producers, in the manner described by
/// `combineLatestWith`.

public func combineLatest<A, B, C, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>) -> SignalProducer<(A, B, C), Error> {
	return combineLatest(a, b)
		.combineLatestWith(c)
		.map(repack)
}

/// Combines the values of all the given producers, in the manner described by
/// `combineLatestWith`.

public func combineLatest<A, B, C, D, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>) -> SignalProducer<(A, B, C, D), Error> {
	return combineLatest(a, b, c)
		.combineLatestWith(d)
		.map(repack)
}

/// Combines the values of all the given producers, in the manner described by
/// `combineLatestWith`.

public func combineLatest<A, B, C, D, E, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>) -> SignalProducer<(A, B, C, D, E), Error> {
	return combineLatest(a, b, c, d)
		.combineLatestWith(e)
		.map(repack)
}

/// Combines the values of all the given producers, in the manner described by
/// `combineLatestWith`.

public func combineLatest<A, B, C, D, E, F, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>, _ f: SignalProducer<F, Error>) -> SignalProducer<(A, B, C, D, E, F), Error> {
	return combineLatest(a, b, c, d, e)
		.combineLatestWith(f)
		.map(repack)
}

/// Combines the values of all the given producers, in the manner described by
/// `combineLatestWith`.

public func combineLatest<A, B, C, D, E, F, G, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>, _ f: SignalProducer<F, Error>, _ g: SignalProducer<G, Error>) -> SignalProducer<(A, B, C, D, E, F, G), Error> {
	return combineLatest(a, b, c, d, e, f)
		.combineLatestWith(g)
		.map(repack)
}

/// Combines the values of all the given producers, in the manner described by
/// `combineLatestWith`.

public func combineLatest<A, B, C, D, E, F, G, H, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>, _ f: SignalProducer<F, Error>, _ g: SignalProducer<G, Error>, _ h: SignalProducer<H, Error>) -> SignalProducer<(A, B, C, D, E, F, G, H), Error> {
	return combineLatest(a, b, c, d, e, f, g)
		.combineLatestWith(h)
		.map(repack)
}

/// Combines the values of all the given producers, in the manner described by
/// `combineLatestWith`.

public func combineLatest<A, B, C, D, E, F, G, H, I, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>, _ f: SignalProducer<F, Error>, _ g: SignalProducer<G, Error>, _ h: SignalProducer<H, Error>, _ i: SignalProducer<I, Error>) -> SignalProducer<(A, B, C, D, E, F, G, H, I), Error> {
	return combineLatest(a, b, c, d, e, f, g, h)
		.combineLatestWith(i)
		.map(repack)
}

/// Combines the values of all the given producers, in the manner described by
/// `combineLatestWith`.

public func combineLatest<A, B, C, D, E, F, G, H, I, J, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>, _ f: SignalProducer<F, Error>, _ g: SignalProducer<G, Error>, _ h: SignalProducer<H, Error>, _ i: SignalProducer<I, Error>, _ j: SignalProducer<J, Error>) -> SignalProducer<(A, B, C, D, E, F, G, H, I, J), Error> {
	return combineLatest(a, b, c, d, e, f, g, h, i)
		.combineLatestWith(j)
		.map(repack)
}

/// Combines the values of all the given producers, in the manner described by
/// `combineLatestWith`. Will return an empty `SignalProducer` if the sequence is empty.

public func combineLatest<S: Sequence, Value, Error>(_ producers: S) -> SignalProducer<[Value], Error> where S.Iterator.Element == SignalProducer<Value, Error> {
	var generator = producers.makeIterator()
	if let first = generator.next() {
		let initial = first.map { [$0] }
		return IteratorSequence(generator).reduce(initial) { producer, next in
			producer.combineLatestWith(next).map { $0.0 + [$0.1] }
		}
	}
	
	return .empty
}

/// Zips the values of all the given producers, in the manner described by
/// `zipWith`.

public func zip<A, B, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>) -> SignalProducer<(A, B), Error> {
	return a.zipWith(b)
}

/// Zips the values of all the given producers, in the manner described by
/// `zipWith`.

public func zip<A, B, C, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>) -> SignalProducer<(A, B, C), Error> {
	return zip(a, b)
		.zipWith(c)
		.map(repack)
}

/// Zips the values of all the given producers, in the manner described by
/// `zipWith`.

public func zip<A, B, C, D, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>) -> SignalProducer<(A, B, C, D), Error> {
	return zip(a, b, c)
		.zipWith(d)
		.map(repack)
}

/// Zips the values of all the given producers, in the manner described by
/// `zipWith`.

public func zip<A, B, C, D, E, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>) -> SignalProducer<(A, B, C, D, E), Error> {
	return zip(a, b, c, d)
		.zipWith(e)
		.map(repack)
}

/// Zips the values of all the given producers, in the manner described by
/// `zipWith`.

public func zip<A, B, C, D, E, F, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>, _ f: SignalProducer<F, Error>) -> SignalProducer<(A, B, C, D, E, F), Error> {
	return zip(a, b, c, d, e)
		.zipWith(f)
		.map(repack)
}

/// Zips the values of all the given producers, in the manner described by
/// `zipWith`.

public func zip<A, B, C, D, E, F, G, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>, _ f: SignalProducer<F, Error>, _ g: SignalProducer<G, Error>) -> SignalProducer<(A, B, C, D, E, F, G), Error> {
	return zip(a, b, c, d, e, f)
		.zipWith(g)
		.map(repack)
}

/// Zips the values of all the given producers, in the manner described by
/// `zipWith`.

public func zip<A, B, C, D, E, F, G, H, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>, _ f: SignalProducer<F, Error>, _ g: SignalProducer<G, Error>, _ h: SignalProducer<H, Error>) -> SignalProducer<(A, B, C, D, E, F, G, H), Error> {
	return zip(a, b, c, d, e, f, g)
		.zipWith(h)
		.map(repack)
}

/// Zips the values of all the given producers, in the manner described by
/// `zipWith`.

public func zip<A, B, C, D, E, F, G, H, I, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>, _ f: SignalProducer<F, Error>, _ g: SignalProducer<G, Error>, _ h: SignalProducer<H, Error>, _ i: SignalProducer<I, Error>) -> SignalProducer<(A, B, C, D, E, F, G, H, I), Error> {
	return zip(a, b, c, d, e, f, g, h)
		.zipWith(i)
		.map(repack)
}

/// Zips the values of all the given producers, in the manner described by
/// `zipWith`.

public func zip<A, B, C, D, E, F, G, H, I, J, Error>(_ a: SignalProducer<A, Error>, _ b: SignalProducer<B, Error>, _ c: SignalProducer<C, Error>, _ d: SignalProducer<D, Error>, _ e: SignalProducer<E, Error>, _ f: SignalProducer<F, Error>, _ g: SignalProducer<G, Error>, _ h: SignalProducer<H, Error>, _ i: SignalProducer<I, Error>, _ j: SignalProducer<J, Error>) -> SignalProducer<(A, B, C, D, E, F, G, H, I, J), Error> {
	return zip(a, b, c, d, e, f, g, h, i)
		.zipWith(j)
		.map(repack)
}

/// Zips the values of all the given producers, in the manner described by
/// `zipWith`. Will return an empty `SignalProducer` if the sequence is empty.

public func zip<S: Sequence, Value, Error>(_ producers: S) -> SignalProducer<[Value], Error> where S.Iterator.Element == SignalProducer<Value, Error> {
	var generator = producers.makeIterator()
	if let first = generator.next() {
		let initial = first.map { [$0] }
		return IteratorSequence(generator).reduce(initial) { producer, next in
			producer.zipWith(next).map { $0.0 + [$0.1] }
		}
	}

	return .empty
}

extension SignalProducerType {
	/// Repeats `self` a total of `count` times. Repeating `1` times results in
	/// an equivalent signal producer.
	
	public func times(_ count: Int) -> SignalProducer<Value, Error> {
		precondition(count >= 0)

		if count == 0 {
			return .empty
		} else if count == 1 {
			return producer
		}

		return SignalProducer { observer, disposable in
			let serialDisposable = SerialDisposable()
			disposable.addDisposable(serialDisposable)

			func iterate(_ current: Int) {
				self.startWithSignal { signal, signalDisposable in
					serialDisposable.innerDisposable = signalDisposable

					signal.observe { event in
						if case .completed = event {
							let remainingTimes = current - 1
							if remainingTimes > 0 {
								iterate(remainingTimes)
							} else {
								observer.sendCompleted()
							}
						} else {
							observer.action(event)
						}
					}
				}
			}

			iterate(count)
		}
	}

	/// Ignores failures up to `count` times.
	
	public func retry(_ count: Int) -> SignalProducer<Value, Error> {
		precondition(count >= 0)

		if count == 0 {
			return producer
		} else {
			return flatMapError { _ in
				self.retry(count - 1)
			}
		}
	}

	/// Waits for completion of `producer`, *then* forwards all events from
	/// `replacement`. Any failure sent from `producer` is forwarded immediately, in
	/// which case `replacement` will not be started, and none of its events will be
	/// be forwarded. All values sent from `producer` are ignored.
	
	public func then<U>(_ replacement: SignalProducer<U, Error>) -> SignalProducer<U, Error> {
		let relay = SignalProducer<U, Error> { observer, observerDisposable in
			self.startWithSignal { signal, signalDisposable in
				observerDisposable.addDisposable(signalDisposable)

				signal.observe { event in
					switch event {
					case let .failed(error):
						observer.sendFailed(error)
					case .completed:
						observer.sendCompleted()
					case .interrupted:
						observer.sendInterrupted()
					case .next:
						break
					}
				}
			}
		}

		return relay.concat(replacement)
	}

	/// Starts the producer, then blocks, waiting for the first value.
	
	public func first() -> Result<Value, Error>? {
		return take(1).single()
	}

	/// Starts the producer, then blocks, waiting for events: Next and Completed.
	/// When a single value or error is sent, the returned `Result` will represent
	/// those cases. However, when no values are sent, or when more than one value
	/// is sent, `nil` will be returned.
	
	public func single() -> Result<Value, Error>? {
		let semaphore = DispatchSemaphore(value: 0)
		var result: Result<Value, Error>?

		take(2).start { event in
			switch event {
			case let .next(value):
				if result != nil {
					// Move into failure state after recieving another value.
					result = nil
					return
				}
				result = .success(value)
			case let .failed(error):
				result = .failure(error)
				semaphore.signal()
			case .completed, .interrupted:
				semaphore.signal()
			}
		}
		
		semaphore.wait(timeout: DispatchTime.distantFuture)
		return result
	}

	/// Starts the producer, then blocks, waiting for the last value.
	
	public func last() -> Result<Value, Error>? {
		return takeLast(1).single()
	}

	/// Starts the producer, then blocks, waiting for completion.
	
	public func wait() -> Result<(), Error> {
		return then(SignalProducer<(), Error>(value: ())).last() ?? .success(())
	}

	/// Creates a new `SignalProducer` that will multicast values emitted by
	/// the underlying producer, up to `capacity`.
	/// This means that all clients of this `SignalProducer` will see the same version
	/// of the emitted values/errors.
	///
	/// The underlying `SignalProducer` will not be started until `self` is started
	/// for the first time. When subscribing to this producer, all previous values
	/// (up to `capacity`) will be emitted, followed by any new values.
	///
	/// If you find yourself needing *the current value* (the last buffered value)
	/// you should consider using `PropertyType` instead, which, unlike this operator,
	/// will guarantee at compile time that there's always a buffered value.
	/// This operator is not recommended in most cases, as it will introduce an implicit
	/// relationship between the original client and the rest, so consider alternatives
	/// like `PropertyType`, `SignalProducer.buffer`, or representing your stream using 
	/// a `Signal` instead.
	///
	/// This operator is only recommended when you absolutely need to introduce
	/// a layer of caching in front of another `SignalProducer`.
	///
	/// This operator has the same semantics as `SignalProducer.buffer`.
	
	public func replayLazily(_ capacity: Int) -> SignalProducer<Value, Error> {
		precondition(capacity >= 0, "Invalid capacity: \(capacity)")

		var producer: SignalProducer<Value, Error>?
		var producerObserver: SignalProducer<Value, Error>.ProducedSignal.Observer?

		let lock = NSLock()
		lock.name = "org.reactivecocoa.ReactiveCocoa.SignalProducer.replayLazily"

		// This will go "out of scope" when the returned `SignalProducer` goes out of scope.
		// This lets us know when we're supposed to dispose the underlying producer.
		// This is necessary because `struct`s don't have `deinit`.
		let token = NSObject()

		return SignalProducer { observer, disposable in
			let initializedProducer: SignalProducer<Value, Error>
			let initializedObserver: SignalProducer<Value, Error>.ProducedSignal.Observer
			let shouldStartUnderlyingProducer: Bool

			lock.lock()
			if let producer = producer, let producerObserver = producerObserver {
				(initializedProducer, initializedObserver) = (producer, producerObserver)
				shouldStartUnderlyingProducer = false
			} else {
				let (producerTemp, observerTemp) = SignalProducer<Value, Error>.buffer(capacity)

				(producer, producerObserver) = (producerTemp, observerTemp)
				(initializedProducer, initializedObserver) = (producerTemp, observerTemp)
				shouldStartUnderlyingProducer = true
			}
			lock.unlock()

			// subscribe `observer` before starting the underlying producer.
			disposable += initializedProducer.start(observer)

			if shouldStartUnderlyingProducer {
				self.producer
					.takeUntil(token.willDeallocSignal)
					.start(initializedObserver)
			}
		}
	}
}

private extension NSObject {
	var willDeallocSignal: SignalProducer<(), NoError> {
		return self
			.rac_willDeallocSignal()
			.toSignalProducer()
			.map { _ in () }
			.mapError { error in
				fatalError("Unexpected error: \(error)")
				()
			}
	}
}
