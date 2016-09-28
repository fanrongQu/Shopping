//
//  FoundationExtensions.swift
//  ReactiveCocoa
//
//  Created by Justin Spahr-Summers on 2014-10-19.
//  Copyright (c) 2014 GitHub. All rights reserved.
//

import Foundation
import enum Result.NoError

extension NotificationCenter {
	/// Returns a producer of notifications posted that match the given criteria.
	/// This producer will not terminate naturally, so it must be explicitly
	/// disposed to avoid leaks.
	public func rac_notifications(_ name: String? = nil, object: AnyObject? = nil) -> SignalProducer<Notification, NoError> {
		return SignalProducer { observer, disposable in
			let notificationObserver = self.addObserver(forName: name, object: object, queue: nil) { notification in
				observer.sendNext(notification)
			}

			disposable.addDisposable {
				self.removeObserver(notificationObserver)
			}
		}
	}
}

private let defaultSessionError = NSError(domain: "org.reactivecocoa.ReactiveCocoa.rac_dataWithRequest", code: 1, userInfo: nil)

extension URLSession {
	/// Returns a producer that will execute the given request once for each
	/// invocation of start().
	public func rac_dataWithRequest(_ request: URLRequest) -> SignalProducer<(Data, URLResponse), NSError> {
		return SignalProducer { observer, disposable in
			let task = self.dataTask(with: request, completionHandler: { data, response, error in
				if let data = data, let response = response {
					observer.sendNext((data, response))
					observer.sendCompleted()
				} else {
					observer.sendFailed(error ?? defaultSessionError)
				}
			}) 

			disposable.addDisposable {
				task.cancel()
			}
			task.resume()
		}
	}
}
