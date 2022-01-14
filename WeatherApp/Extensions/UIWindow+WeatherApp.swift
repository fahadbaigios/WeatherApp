//
//  UIWindow+WeatherApp.swift
//  WeatherApp
//
//  Created by Fahad Baig on 14/01/2022.
//

import UIKit

public extension UIWindow {

	/// Set window rootController, make it key and visible
	///
	/// - Parameters:
	///   - viewController: rootContoller
	///   - animated: isAnimated
	///   - duration: animation duration
	///   - options: animation options
	func transition(toViewController viewController: UIViewController, duration: Double = 0.5, options: AnimationOptions? = nil) {
		self.rootViewController = viewController
		self.makeKeyAndVisible()

		guard let animationOptions = options else { return }
		transitionAnimation(duration: duration, options: animationOptions)
	}

	func transitionAnimation(duration: Double, options: AnimationOptions) {
		UIView.transition(with: self,
						  duration: duration,
						  options: options,
						  animations: nil,
						  completion: nil)
	}
}
