//
//  WeatherListViewModel.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

protocol WeatherListViewModelDelegate: AnyObject {
    func didFetchWeathers()
    func didFailToFetchWeathersData(_ error: Error)
}

final class WeatherListViewModel {
    private var weathers: [Weather] = []
    private let weatherLoader: WeatherLoader
    weak var delegate: WeatherListViewModelDelegate?
    
    var itemCount: Int {
        weathers.count
    }
    
    init(weatherLoader: WeatherLoader) {
        self.weatherLoader = weatherLoader
    }
    
    func weather(at indexPath: IndexPath) -> Weather {
        weathers[indexPath.item]
    }
    
    func fetch() {
        weatherLoader.load { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let weathers):
                    self.weathers = weathers
                    delegate?.didFetchWeathers()
                case .failure(let error):
                    delegate?.didFailToFetchWeathersData(error)
            }
        }
    }
}
