//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Fahad Baig on 12/01/2022.
//

import UIKit
import Store
import RxFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
	let coordinator = FlowCoordinator()
	
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
		initializeCoordinator(windowScene: windowScene)
    }

	/// initialize app coordinator
	/// - Parameter windowScene: window
	private func initializeCoordinator(windowScene: UIWindowScene) {
		//Make Window
		let window = UIWindow(windowScene: windowScene)
		self.window = window
		window.makeKeyAndVisible()

		//start coordinator
		let serviceManager = MoyaWebServiceManager(baseUrl: URL(string: "https://api.openweathermap.org/data/2.5")!)
		let service = ServiceFactory.makeWeatherService(appid: Keys.appid, serviceManager: serviceManager)
		let stepper = AppStepper(initialStep: AppStep.weatherForecast)
		let appFlow = AppFlow(window: window, service: service)
		coordinator.coordinate(flow: appFlow, with: stepper)
	}
}

