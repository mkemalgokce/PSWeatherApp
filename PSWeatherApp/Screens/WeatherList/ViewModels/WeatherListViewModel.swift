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
    
    func didAddToFavourite()
    func didFailToAddFavourite(_ error: Error)
    
    func didRemoveToFavourite()
    func didFailToRemoveFavourite(_ error: Error)
}

final class WeatherListViewModel {
    private var weathers: [Weather] = []
    private let weatherLoader: WeatherLoader
    private let favouriteManager: FavouriteManagerProtocol?
    
    weak var delegate: WeatherListViewModelDelegate?
    
    var itemCount: Int {
        weathers.count
    }
    
    init(weatherLoader: WeatherLoader, favouriteManager: FavouriteManagerProtocol? = nil) {
        self.weatherLoader = weatherLoader
        self.favouriteManager = favouriteManager
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
    
    func addWeatherToFavourites(_ weather: Weather) {
        do {
            try favouriteManager?.save(weather: weather)
            delegate?.didAddToFavourite()
        }catch {
            delegate?.didFailToAddFavourite(error)
        }
    }
    
    func removeWeatherFromFavourites(_ weather: Weather) {
        do {
            try favouriteManager?.delete(weather: weather)
            delegate?.didRemoveToFavourite()
        }catch {
            delegate?.didFailToRemoveFavourite(error)
        }
    }
}
