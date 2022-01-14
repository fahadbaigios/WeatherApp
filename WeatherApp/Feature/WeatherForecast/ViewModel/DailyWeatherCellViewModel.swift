//
//  DailyWeatherCellViewModel.swift
//  WeatherApp
//
//  Created by Fahad Baig on 13/01/2022.
//

import Foundation
import Store
import RxSwift

protocol DailyWeatherCellViewModelOutput {
	var title: Observable<String> {get}
	var temperature: Observable<String> {get}
	var feelsLike: Observable<String> {get}
	var humidity: Observable<String> {get}
	var icon: Observable<URL?> {get}
}

class DailyWeatherCellViewModel: DailyWeatherCellViewModelOutput {

	let title: Observable<String>
	let temperature: Observable<String>
	let feelsLike: Observable<String>
	let humidity: Observable<String>
	let icon: Observable<URL?>

	init(dailyWeather: Daily) {

		let dateformatter = DateFormatter()
		dateformatter.dateFormat = "dd EEEE"
		title = Observable.just(dateformatter.string(from: Date(timeIntervalSince1970: TimeInterval(dailyWeather.dt))))
		temperature = Observable.just("\(dailyWeather.temp.min)°/\(dailyWeather.temp.max)°")
		feelsLike = Observable.just("Feels like \(dailyWeather.feelsLike.day)°")
		humidity = Observable.just("Humidity: \(dailyWeather.humidity)%")
		let iconName = dailyWeather.weather.first?.icon ?? ""
		icon = Observable.just(URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png"))
	}
}
