//
//  AppFlow.swift
//  WeatherApp
//
//  Created by Fahad Baig on 24/11/2020.
//

import RxFlow
import RxRelay
import Store

class AppStepper: Stepper {
	var steps = PublishRelay<Step>()
	let initialStep: Step

	init(initialStep: Step) {
		self.initialStep = initialStep
	}
}

class AppFlow: Flow {
	
	var root: Presentable { rootViewController }
	private var rootViewController: UINavigationController { UINavigationController() }
	weak var window: UIWindow?
	private let service: WeatherService

	init(window: UIWindow, service: WeatherService) {
		self.window = window
		self.service = service
	}

	func navigate(to step: Step) -> FlowContributors {
		switch step as? AppStep {
		case .weatherForecast:
			return navigateToWeatherForecastViewController(service: service)
		default:
			return .none
		}
	}

	private func navigateToWeatherForecastViewController(service: WeatherService) -> FlowContributors {
		let viewModel = WeatherForecastViewModel(locationProvider: CoreLocationProvider(), service: service)
		let viewController = WeatherForecastViewController.instantiate()
		viewController.viewModel = viewModel
		window?.transition(toViewController: viewController)
		return viewController.contributor(from: viewModel)
	}
}
