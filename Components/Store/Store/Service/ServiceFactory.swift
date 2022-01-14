//
//  ServiceFactory.swift
//  Store
//
//  Created by Fahad Baig on 14/01/2022.
//

import Foundation

public class ServiceFactory {

	static public func makeWeatherService(appid: String, serviceManager: WebServiceManager) -> WeatherService {
		return WeatherRemoteService(appid: appid, serviceManager: serviceManager)
	}
}
