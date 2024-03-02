//
//  WeatherItemsMapper.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

final class WeatherItemsMapper {
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Weather] {
        guard response.statusCode == 200,
              let decoded = try? JSONDecoder().decode([Weather].self, from: data) else {
            throw RemoteWeatherLoader.Error.invalidData
        }
        
        return decoded
    }
}
