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
        
    typealias Result = LoadWeatherResult
    
    init(store: WeatherStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    func load(completion: @escaping (Result) -> Void) {
        do {
            if let cache = try store.retrieve(), WeatherCachePolicy.validate(cache.timestamp ?? Date(), against: currentDate()) {
                completion(.success(cache.weather))
            }
        }catch {
            completion(.failure(error))
        }
    }
    
    func save(_ weather: [Weather]) throws {
        try store.deleteWeather()
        try store.insert(weather, timestamp: currentDate())
    }
    
}

extension LocalWeatherLoader {
    private struct InvalidCache: Swift.Error {}
    
    public func validateCache() throws {
        do {
            let cache = try store.retrieve()
            if !WeatherCachePolicy.validate(cache?.timestamp ?? Date(), against: currentDate()) {
                throw InvalidCache()
            }
        } catch {
            try store.deleteWeather()
        }
    }
}
