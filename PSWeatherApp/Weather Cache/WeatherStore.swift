//
//  WeatherStore.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

typealias WeatherWithTimestamp = (weather: [Weather], timestamp: Date?)

protocol WeatherStore {
    func deleteWeather() throws
    func insert(_ weather: [Weather], timestamp: Date) throws
    func retrieve() throws -> WeatherWithTimestamp?
}

