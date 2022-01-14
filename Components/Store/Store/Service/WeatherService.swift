//
//  WeatherService.swift
//  Store
//
//  Created by Fahad Baig on 13/01/2022.
//

import Foundation
import RxSwift
import Alamofire

public protocol WeatherService {
	func fetchCurrentWeather(city: String) -> Single<CurrentWeatherModel>
	func fetchDailyWeather(lat: Double, lng: Double) -> Single<DailyWeatherModel>
}

public class WeatherRemoteService: WeatherService {

	private let appid: String
	let serviceManager: WebServiceManager

	init(appid: String, serviceManager: WebServiceManager) {
		self.appid = appid
		self.serviceManager = serviceManager
	}

	public func fetchCurrentWeather(city: String) -> Single<CurrentWeatherModel> {
		let request: Single<CurrentWeatherModel> = serviceManager.newRequest(method: .get, task: .requestParameters(parameters: ["q":city, "appid":appid], encoding: URLEncoding.default), path: "/weather", headers: nil)
		return request

	}

	public func fetchDailyWeather(lat: Double, lng: Double) -> Single<DailyWeatherModel> {
		let request: Single<DailyWeatherModel> = serviceManager.newRequest(method: .get, task: .requestParameters(parameters: ["lat": lat,"lon":lng,"appid": appid], encoding: URLEncoding.default), path: "/onecall", headers: nil)
		return request
	}
}
