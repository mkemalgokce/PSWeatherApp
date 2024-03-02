//
//  WeatherListViewModel.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

protocol WeatherListViewModelDelegate: AnyObject {
    
}

final class WeatherListViewModel {
    private let weatherLoader: WeatherLoader
    weak var delegate: WeatherListViewModelDelegate?
    
    init(weatherLoader: WeatherLoader) {
        self.weatherLoader = RemoteWeatherLoader(url: .applicationDirectory, client: URLSessionHTTPClient(session: .shared))
    }
    
    func update() {
        weatherLoader.load { result in
            
        }
    }
}
