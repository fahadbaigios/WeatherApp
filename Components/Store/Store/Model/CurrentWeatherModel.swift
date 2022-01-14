//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Fahad Baig on 12/01/2022.
//

import Foundation

// MARK: - ServiceInput
public struct CurrentWeatherModel: Codable {
	public let coord: Coord
	public let weather: [Weather]
	public let base: String
	public let main: Main
	public let visibility: Int
	public let wind: Wind
	public let clouds: Clouds
	public let dt: Int
	public let sys: Sys
	public let timezone, id: Int
	public let name: String
	public let cod: Int

	public init(coord: Coord, weather: [Weather], base: String, main: Main, visibility: Int, wind: Wind, clouds: Clouds, dt: Int, sys: Sys, timezone: Int, id: Int, name: String, cod: Int) {
		self.coord = coord
		self.weather = weather
		self.base = base
		self.main = main
		self.visibility = visibility
		self.wind = wind
		self.clouds = clouds
		self.dt = dt
		self.sys = sys
		self.timezone = timezone
		self.id = id
		self.name = name
		self.cod = cod
	}
}

// MARK: - Clouds
public struct Clouds: Codable {
	public let all: Int

	public init(all: Int) {
		self.all = all
	}
}

// MARK: - Coord
public struct Coord: Codable {
	public let lon, lat: Double

	public init(lon: Double, lat: Double) {
		self.lon = lon
		self.lat = lat
	}
}

// MARK: - Main
public struct Main: Codable {
	public let temp, feelsLike, tempMin, tempMax: Double
	public let pressure, humidity: Int

	enum CodingKeys: String, CodingKey {
		case temp
		case feelsLike
		case tempMin
		case tempMax
		case pressure, humidity
	}

	public init(temp: Double, feelsLike: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int) {
		self.temp = temp
		self.feelsLike = feelsLike
		self.tempMin = tempMin
		self.tempMax = tempMax
		self.pressure = pressure
		self.humidity = humidity
	}
}

// MARK: - Sys
public struct Sys: Codable {
	public let type, id: Int
	public let country: String
	public let sunrise, sunset: Int

	public init(type: Int, id: Int, country: String, sunrise: Int, sunset: Int) {
		self.type = type
		self.id = id
		self.country = country
		self.sunrise = sunrise
		self.sunset = sunset
	}
}

// MARK: - Weather
public struct Weather: Codable {
	public let id: Int
	public let main, icon: String
	public var weatherDescription: String?

	enum CodingKeys: String, CodingKey {
		case id, main
		case weatherDescription
		case icon
	}

	public init(id: Int, main: String, weatherDescription: String, icon: String) {
		self.id = id
		self.main = main
		self.weatherDescription = weatherDescription
		self.icon = icon
	}
}

// MARK: - Wind
public struct Wind: Codable {
	public let speed: Double
	public let deg: Int

	public init(speed: Double, deg: Int) {
		self.speed = speed
		self.deg = deg
	}
}
