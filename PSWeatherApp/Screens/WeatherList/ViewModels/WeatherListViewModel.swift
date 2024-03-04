//
//  WeatherListViewModel.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

protocol WeatherListViewModelDelegate: AnyObject {
    
    func didStartLoading()
    
    func didFetchWeathers()
    func didFailToFetchWeathersData(_ error: Error)
    
    func didAddToFavourite()
    func didFailToAddFavourite(_ error: Error)
    
    func didRemoveToFavourite()
    func didFailToRemoveFavourite(_ error: Error)
}

class WeatherListViewModel {
    private var weathers: [Weather] = []
    
    private var filteredWeathers: [Weather] = []
    
    private var currentPage: Int = 0
    private let itemsPerPage: Int = 20
    
    private var paginatedWeathers: [Weather] {
        let endIndex = min((currentPage + 1) * itemsPerPage, weathers.count)
        return Array(weathers[0 ..< endIndex])
    }
    
    
    private let weatherLoader: WeatherLoader
    private let favouriteManager: FavouriteManagerProtocol?
    
    weak var delegate: WeatherListViewModelDelegate?
    
    func itemCount(isFiltering: Bool) -> Int {
        isFiltering ? filteredWeathers.count : paginatedWeathers.count
    }
    
    init(weatherLoader: WeatherLoader, favouriteManager: FavouriteManagerProtocol? = nil) {
        self.weatherLoader = weatherLoader
        self.favouriteManager = favouriteManager
    }
    
    func weather(at indexPath: IndexPath) -> Weather {
        paginatedWeathers[indexPath.item]
    }
    
    func filtered(at indexPath: IndexPath) -> Weather {
        filteredWeathers[indexPath.item]
    }
    
    func item(isFiltering: Bool, at indexPath: IndexPath) -> Weather {
        isFiltering ? filteredWeathers[indexPath.item] : weathers[indexPath.item]
    }
    
    func fetch() {
        delegate?.didStartLoading()
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
        delegate?.didStartLoading()
        do {
            try favouriteManager?.save(weather: weather)
            delegate?.didAddToFavourite()
        }catch {
            delegate?.didFailToAddFavourite(error)
        }
    }
    
    func removeWeatherFromFavourites(_ weather: Weather) {
        delegate?.didStartLoading()
        do {
            try favouriteManager?.delete(weather: weather)
            delegate?.didRemoveToFavourite()
        }catch {
            delegate?.didFailToRemoveFavourite(error)
        }
    }
    
    func filter(with input: String) {
        filteredWeathers = weathers.filter {
            $0.country.lowercased().contains(input.lowercased()) || $0.city.lowercased().contains(input.lowercased())
        }
    }
    
    func goToNextPage() {
        if currentPage < weathers.count / itemsPerPage {
            currentPage += 1
        }
    }
}
