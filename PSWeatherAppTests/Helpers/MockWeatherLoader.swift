//
//  MockWeatherLoader.swift
//  PSWeatherAppTests
//
//  Created by Mustafa Kemal Gökçe on 4.03.2024.
//

import Foundation
@testable import PSWeatherApp

class MockWeatherLoader: WeatherLoader {
    var mockResult: Result<[Weather], Error>?
    
    func load(completion: @escaping (Result<[Weather], Error>) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
}
