//
//  Weather+Utils.swift
//  PSWeatherLoaderTests
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation
import PSWeatherApp

extension Weather {
    static func generate(id: Int, city: String, country: String) -> Weather {
        Weather(id: id,
                city: city,
                country: country,
                temperature: Double.random(in: 0..<12),
                weatherDescription: .random() ,
                humidity: Int.random(in: 0..<50),
                windSpeed: Double.random(in: 0..<12),
                forecast: [])
    }
}
extension WeatherDescription {
    static func random() -> WeatherDescription {
            let allCases = [
                clearSky, cloudy, partlyCloudy, rain, rainShowers, rainy, scatteredClouds, sunny, weatherDescriptionPartlyCloudy
            ]
            let randomIndex = Int.random(in: 0..<allCases.count)
            return allCases[randomIndex]
        }
}
