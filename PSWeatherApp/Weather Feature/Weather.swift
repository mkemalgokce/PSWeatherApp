//
//  Weather.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

// MARK: - Weather
public struct Weather: Equatable, Codable {
    public static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.city == rhs.city && lhs.country == rhs.country && lhs.id == rhs.id
    }
    
    public let id: Int
    public let city, country: String
    public let temperature: Double
    public let weatherDescription: WeatherDescription
    public let humidity: Int
    public let windSpeed: Double
    public let forecast: [Forecast]

    enum CodingKeys: String, CodingKey {
        case id, city, country, temperature
        case weatherDescription = "weather_description"
        case humidity
        case windSpeed = "wind_speed"
        case forecast
    }
    
    
    public init(id: Int, city: String, country: String, temperature: Double, weatherDescription: WeatherDescription, humidity: Int, windSpeed: Double, forecast: [Forecast]) {
        self.id = id
        self.city = city
        self.country = country
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.forecast = forecast
    }
    
}

// MARK: - Forecast
public struct Forecast: Codable {
    public let date: String
    public let temperature: Int
    public let weatherDescription: WeatherDescription
    public let humidity: Int
    public let windSpeed: Double

    enum CodingKeys: String, CodingKey {
        case date, temperature
        case weatherDescription = "weather_description"
        case humidity
        case windSpeed = "wind_speed"
    }
    
    public init(date: String, temperature: Int, weatherDescription: WeatherDescription, humidity: Int, windSpeed: Double) {
        self.date = date
        self.temperature = temperature
        self.weatherDescription = weatherDescription
        self.humidity = humidity
        self.windSpeed = windSpeed
    }
}

public enum WeatherDescription: String, Equatable, Codable {
    case clearSky = "Clear sky"
    case cloudy = "Cloudy"
    case partlyCloudy = "Partly cloudy"
    case rain = "Rain"
    case rainShowers = "Rain showers"
    case rainy = "Rainy"
    case scatteredClouds = "Scattered clouds"
    case sunny = "Sunny"
    case weatherDescriptionPartlyCloudy = "Partly Cloudy"
}
