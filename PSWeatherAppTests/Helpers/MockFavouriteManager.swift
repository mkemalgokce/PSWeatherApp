//
//  MockFavouriteManager.swift
//  PSWeatherAppTests
//
//  Created by Mustafa Kemal Gökçe on 4.03.2024.
//

import Foundation
@testable import PSWeatherApp

class MockFavouriteManager: FavouriteManagerProtocol {
    var mockLoadResult: Result<[Weather], Error>?
    var savedWeather: Weather?
    
    func load(completion: @escaping (Result<[Weather], Error>) -> Void) {
        if let result = mockLoadResult {
            completion(result)
        }
    }
    
    func save(weather: Weather) throws {
        savedWeather = weather
    }
    
    func delete(weather: Weather) throws {
        savedWeather = nil
    }
    
    func isInStore(_ weather: Weather) throws -> Bool {
        savedWeather == weather
    }
}



