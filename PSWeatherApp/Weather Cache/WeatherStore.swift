//
//  WeatherStore.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

typealias CachedWeather = (weather: [Weather], timestamp: Date)

protocol WeatherStore {
    func deleteCachedWeather() throws
    func insert(_ weather: [Weather], timestamp: Date) throws
    func retrieve() throws -> CachedWeather?
}


