//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Fahad Baig on 13/01/2022.
//

import Foundation
import RxSwift
import Store

protocol CurrentWeatherViewModelOutput {
	var city: Observable<String> {get}
	var temperature: Observable<String> {get}
	var feelsLike: Observable<String> {get}
	var humidity: Observable<String> {get}
	var icon: Observable<URL?> {get}
}

class CurrentWeatherViewModel: CurrentWeatherViewModelOutput {

	var city: Observable<String>
	var temperature: Observable<String>
	var feelsLike: Observable<String>
	var humidity: Observable<String>
	var icon: Observable<URL?>

	init(currentWeather: CurrentWeatherModel) {
		city = Observable.just(currentWeather.name)
		temperature = Observable.just("\(currentWeather.main.temp)° (\(currentWeather.main.tempMin)°/\(currentWeather.main.tempMax)°)")
		feelsLike = Observable.just("Feels like \(currentWeather.main.feelsLike)°")
		humidity = Observable.just("Humidity: \(currentWeather.main.humidity)%")
		let iconName = currentWeather.weather.first?.icon ?? ""
		icon = Observable.just(URL(string:"https://openweathermap.org/img/wn/\(iconName)@2x.png"))
	}
}
