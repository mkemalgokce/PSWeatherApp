//
//  WeatherEndPoint.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import Foundation

enum WeatherEndPoint {
    static let baseURL: String = "https://freetestapi.com"
    
    case get
    
    var url: URL {
        switch self {
            case .get:
                return URL(string: "\(Self.baseURL)/api/v1/weathers")!
        }
    }
}
