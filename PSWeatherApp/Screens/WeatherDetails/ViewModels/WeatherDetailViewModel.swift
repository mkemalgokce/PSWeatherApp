//
//  WeatherDetailViewModel.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import Foundation

protocol WeatherDetailViewModelDelegate: AnyObject {
    func didAddToFavourite()
    func didFailToAddFavourite(_ error: Error)
    
    func didRemoveToFavourite()
    func didFailToRemoveFavourite(_ error: Error)
}
final class WeatherDetailViewModel {
    private let favouriteManager: FavouriteManagerProtocol
    var weather: Weather
    
    weak var delegate:WeatherDetailViewModelDelegate?
    
    
    var foreCastCount: Int {
        weather.forecast.count
    }
    
    var isInFavourite: Bool {
        do {
            return try favouriteManager.isInStore(weather)
        }catch {
            print("Error on: \(error)")
            return false
        }
    }
    
    init(weather: Weather, favouriteManager: FavouriteManagerProtocol) {
        self.weather = weather
        self.favouriteManager = favouriteManager
    }
    
    func forecast(at index: IndexPath) -> Forecast {
        weather.forecast[index.item]
    }
    
    
    func favourite() {
        if !isInFavourite {
            addToFavourites()
        }else {
            removeFromFavourites()
        }
    }
    
    func removeFromFavourites() {
        do {
            try favouriteManager.delete(weather: weather)
            delegate?.didRemoveToFavourite()
        }catch {
            delegate?.didFailToRemoveFavourite(error)
        }
        
    }
    
    func addToFavourites() {
        do {
            try favouriteManager.save(weather: weather)
            delegate?.didAddToFavourite()
        }catch {
            delegate?.didFailToAddFavourite(error)
        }
    }
    
}
