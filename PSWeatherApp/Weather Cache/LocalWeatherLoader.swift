//
//  LocalWeatherLoader.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

final class LocalWeatherLoader: WeatherLoader {
    
    private let store: WeatherStore
    
    typealias Result = LoadWeatherResult
    
    init(store: WeatherStore) {
        self.store = store
    }
    
    func load(completion: @escaping (Result) -> Void) {
        
    }
    
}
