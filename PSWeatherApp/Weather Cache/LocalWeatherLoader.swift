//
//  LocalWeatherLoader.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

final class LocalWeatherLoader: WeatherLoader {
    private let store: WeatherStore
    private let currentDate: () -> Date
    
    enum Error: Swift.Error {
        case cacheNotFound
    }
    
    typealias Result = LoadWeatherResult
    
    init(store: WeatherStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    func load(completion: @escaping (Result) -> Void) {
        if let cache = try? store.retrieve(), WeatherCachePolicy.validate(cache.timestamp, against: currentDate()) {
            completion(.success(cache.weather))
        }else {
            completion(.failure(Error.cacheNotFound))
        }
    }
    
    func save(_ weather: [Weather]) throws {
        try store.deleteCachedWeather()
        try store.insert(weather, timestamp: currentDate())
    }
    
}

extension LocalWeatherLoader {
    private struct InvalidCache: Swift.Error {}
    
    public func validateCache() throws {
        do {
            if let cache = try store.retrieve(), !WeatherCachePolicy.validate(cache.timestamp, against: currentDate()) {
                throw InvalidCache()
            }
        } catch {
            try store.deleteCachedWeather()
        }
    }
}
