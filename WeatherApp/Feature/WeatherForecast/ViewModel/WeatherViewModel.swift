//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Fahad Baig on 12/01/2022.
//

import Foundation
import RxSwift
import Store
import CoreLocation
import RxCocoa
import RxFlow

protocol WeatherViewModelOutput {
	var showSettingIcon: Observable<Bool> {get}
	var currentWeatherViewModel: Observable<CurrentWeatherViewModelOutput> {get}
	var dailyWeather: Observable<[DailyWeatherCellViewModelOutput]> {get}
	var showLoading: Observable<Bool> {get}
}

protocol WeatherViewModelInput {
	var loadWeather: AnyObserver<Void> {get}
}

typealias WeatherViewModel = WeatherViewModelOutput & WeatherViewModelInput

class WeatherForecastViewModel: Stepper, WeatherViewModelOutput, WeatherViewModelInput {

	private let locationProvider: LocationProvider
	private let disposeBag = DisposeBag()
	//WeatherViewModelOutput
	let showSettingIcon: Observable<Bool>
	let currentWeatherViewModel: Observable<CurrentWeatherViewModelOutput>
	let dailyWeather: Observable<[DailyWeatherCellViewModelOutput]>
	let showLoading: Observable<Bool>
	//WeatherViewModelInput
	let loadWeather: AnyObserver<Void>
	//Stepper
	let steps = PublishRelay<Step>()

	init(locationProvider: LocationProvider, service: WeatherService) {
		let showSettingIcon = ReplaySubject<Bool>.create(bufferSize: 1)
		let loadWeather = PublishSubject<Void>()
		let showLoading = ReplaySubject<Bool>.create(bufferSize: 1)

		self.locationProvider = locationProvider
		self.showSettingIcon = showSettingIcon
		self.showLoading = showLoading
		self.loadWeather = loadWeather.asObserver()

		//load location to update weather
		loadWeather.debug("LoadWeather", trimOutput: true).subscribe(onNext: {
			locationProvider.requestLocation(frequency: .once)
			showLoading.onNext(true)
		}).disposed(by: disposeBag)

		//bind location provider status
		locationProvider.status.map{$0 != .authorizedWhenInUse}.bind(to: showSettingIcon).disposed(by: disposeBag)

		//bind current weather
		currentWeatherViewModel = locationProvider.location.debug("CurrentWeather", trimOutput: true).flatMap{locationProvider.getCity(location: $0)}
		.flatMap{service.fetchCurrentWeather(city: $0)}
		.map{CurrentWeatherViewModel(currentWeather: $0)}
		.do(onNext: { _ in
			showLoading.onNext(false)
		}).share()

		//bind daily weather
		dailyWeather = locationProvider.location.debug("DailyWeather", trimOutput: true).flatMap{service.fetchDailyWeather(lat: $0.coordinate.latitude, lng: $0.coordinate.longitude)}
		.map{$0.daily.map{DailyWeatherCellViewModel(dailyWeather: $0)}}
	}
}
