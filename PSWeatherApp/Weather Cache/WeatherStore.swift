//
//  WeatherStore.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

typealias CachedWeather = (feed: [Weather], timestamp: Date)

protocol WeatherStore {
    func deleteCachedFeed() throws
    func insert(_ feed: [Weather], timestamp: Date) throws
    func retrieve() throws -> CachedWeather?
}
