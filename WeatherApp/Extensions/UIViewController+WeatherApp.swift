//
//  UIViewController+WeatherApp.swift
//  WeatherApp
//
//  Created by Fahad Baig on 14/01/2022.
//

import UIKit
import RxFlow

public extension UIViewController {
	func contributor(from stepper: Stepper) -> FlowContributors {
		let flowContributor = FlowContributor.contribute(withNextPresentable: self, withNextStepper: stepper)
		return FlowContributors.one(flowContributor: flowContributor)
	}
}
