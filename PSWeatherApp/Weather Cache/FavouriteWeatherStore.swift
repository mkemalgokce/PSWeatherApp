//
//  FavouriteWeatherStore.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import Foundation
import CoreData

protocol FavouriteStore {
    func saveFavourite(_ weather: Weather) throws
    func deleteFavourite(_ weather: Weather) throws
    func retrieve() throws -> [Weather]
    func find(_ weather: Weather) throws -> Bool
}


final class FavouriteWeatherStore: FavouriteStore {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveFavourite(_ weather: Weather) throws {
        let favourites = FavouritesEntity(context: context)
        
        let favourite = FavouriteWeatherEntity.create(from: weather, context: context)
        favourites.addToWeather(favourite)
        
        try context.save()
    }
    
    func deleteFavourite(_ weather: Weather) throws {
        try context.performAndWait {
            let favouriteEntities = try context.fetch(FavouritesEntity.fetchRequest())
            
            for favouriteEntity in favouriteEntities {
                guard let weathers = favouriteEntity.weather else { continue }
                for weather in weathers {
                    if let weatherEntity = weather as? WeatherEntity {
                        try WeatherEntity.delete(weatherEntity, context: context)
                    }
                }
                context.delete(favouriteEntity)
            }
            
            try context.save()
        }
    }
    
    func retrieve() throws -> [Weather] {
        try context.performAndWait {
            let fetchRequest: NSFetchRequest<FavouritesEntity> = FavouritesEntity.fetchRequest()
            
            let result = try context.fetch(fetchRequest)
            
            if let first = result.first {
                return first.toWeathers()
            }
            
            return []
        }

    }
    
    func find(_ weather: Weather) throws -> Bool {
        
        let fetchRequest: NSFetchRequest<FavouritesEntity> = FavouritesEntity.fetchRequest()
        
        let result = try context.fetch(fetchRequest)
        
        if let first = result.first {
            let weathers = first.toWeathers()
            return weathers.contains{ $0 == weather }
        }else {
            return false
        }
        
    }
    
    
}
