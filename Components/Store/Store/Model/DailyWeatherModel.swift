//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Fahad Baig on 12/01/2022.
//

import Foundation

// MARK: - DailyWeatherModel
public struct DailyWeatherModel: Codable {

	public let lat, lon: Double
	public let timezone: String
	public let timezoneOffset: Int
	public let daily: [Daily]

	enum CodingKeys: String, CodingKey {
		case lat, lon, timezone
		case timezoneOffset
		case daily
	}

	public init(lat: Double, lon: Double, timezone: String, timezoneOffset: Int, daily: [Daily]) {
		self.lat = lat
		self.lon = lon
		self.timezone = timezone
		self.timezoneOffset = timezoneOffset
		self.daily = daily
	}
}

// MARK: - Daily
public struct Daily: Codable {
	public let dt, sunrise, sunset, moonrise: Int
	public let moonset: Int
	public let moonPhase: Double
	public let temp: Temp
	public let feelsLike: FeelsLike
	public let pressure, humidity: Int
	public let dewPoint, windSpeed: Double
	public let windDeg: Int
	public let windGust: Double
	public let weather: [Weather]
	public let clouds: Int
	public let pop, uvi: Double
	public let rain: Double?

	enum CodingKeys: String, CodingKey {
		case dt, sunrise, sunset, moonrise, moonset
		case moonPhase
		case temp
		case feelsLike
		case pressure, humidity
		case dewPoint
		case windSpeed
		case windDeg
		case windGust
		case weather, clouds, pop, uvi, rain
	}

	public init(dt: Int, sunrise: Int, sunset: Int, moonrise: Int, moonset: Int, moonPhase: Double, temp: Temp, feelsLike: FeelsLike, pressure: Int, humidity: Int, dewPoint: Double, windSpeed: Double, windDeg: Int, windGust: Double, weather: [Weather], clouds: Int, pop: Double, uvi: Double, rain: Double?) {
		self.dt = dt
		self.sunrise = sunrise
		self.sunset = sunset
		self.moonrise = moonrise
		self.moonset = moonset
		self.moonPhase = moonPhase
		self.temp = temp
		self.feelsLike = feelsLike
		self.pressure = pressure
		self.humidity = humidity
		self.dewPoint = dewPoint
		self.windSpeed = windSpeed
		self.windDeg = windDeg
		self.windGust = windGust
		self.weather = weather
		self.clouds = clouds
		self.pop = pop
		self.uvi = uvi
		self.rain = rain
	}
}

// MARK: - FeelsLike
public struct FeelsLike: Codable {
	public let day, night, eve, morn: Double

	public init(day: Double, night: Double, eve: Double, morn: Double) {
		self.day = day
		self.night = night
		self.eve = eve
		self.morn = morn
	}
}

// MARK: - Temp
public struct Temp: Codable {
	public let day, min, max, night: Double
	public let eve, morn: Double

	public init(day: Double, min: Double, max: Double, night: Double, eve: Double, morn: Double) {
		self.day = day
		self.min = min
		self.max = max
		self.night = night
		self.eve = eve
		self.morn = morn
	}
}
