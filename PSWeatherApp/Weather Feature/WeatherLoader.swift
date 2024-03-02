//
//  WeatherLoader.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

protocol WeatherLoader {
    func load(completion: @escaping (Result<[Weather], Error>) -> Void)
}
