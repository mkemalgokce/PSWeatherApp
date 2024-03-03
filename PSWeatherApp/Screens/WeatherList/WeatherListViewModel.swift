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
    
    init(weatherLoader: WeatherLoader) {
        self.weatherLoader = RemoteWeatherLoader(url: .applicationDirectory, client: URLSessionHTTPClient(session: .shared))
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
