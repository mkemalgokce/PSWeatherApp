//
//  WeatherLoader.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

public typealias LoadWeatherResult = Result<[Weather], Error>

protocol WeatherLoader {
    func load(completion: @escaping (LoadWeatherResult) -> Void)
}
