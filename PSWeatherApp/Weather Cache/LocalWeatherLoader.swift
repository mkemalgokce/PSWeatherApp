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
        
    }
    
    func save(_ weather: [Weather]) throws {
            try store.deleteCachedWeather()
            try store.insert(weather, timestamp: currentDate())
        }
    
}
