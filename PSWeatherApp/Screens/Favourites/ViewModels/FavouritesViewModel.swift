//
//  FavouritesViewModel.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import Foundation

protocol FavouritesViewModelDelegate: AnyObject {
    func didFetchWeathers()
    func didFailToFetchWeathers(_ error: Error)
}

final class FavouritesViewModel {
    private var weathers: [Weather] = []
    private let favouriteManager: FavouriteManagerProtocol
    
    weak var delegate: FavouritesViewModelDelegate?
    
    var itemCount: Int {
        weathers.count
    }
    
    init(favouriteManager: FavouriteManagerProtocol) {
        self.favouriteManager = favouriteManager
    }
    
    func fetch() {
        favouriteManager.load { [weak self] result in
            print("Result: \(result)")
            guard let self else { return }
            switch result {
                case .success(let success):
                    weathers = success
                    delegate?.didFetchWeathers()
                case .failure(let failure):
                    delegate?.didFailToFetchWeathers(failure)
            }
        }
    }
    
    func weather(at indexPath: IndexPath) -> Weather {
        return weathers[indexPath.item]
    }
}
