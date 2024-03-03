//
//  FavouritesEntity+CoreDataProperties.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//
//

import Foundation
import CoreData


extension FavouritesEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritesEntity> {
        return NSFetchRequest<FavouritesEntity>(entityName: "FavouritesEntity")
    }
    
    @NSManaged public var weather: NSSet?
    
}

// MARK: Generated accessors for weather
extension FavouritesEntity {
    
    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: FavouriteWeatherEntity)
    
    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: FavouriteWeatherEntity)
    
    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)
    
    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)
    
}

extension FavouritesEntity : Identifiable {
    
    func toWeathers() -> [Weather] {
        guard let weather else { fatalError("Error on casting Favourite Entity") }
        var weathers: [Weather] = []
        for entity in weather {
            if let weatherEntity = entity as? FavouriteWeatherEntity {
                weathers.append(weatherEntity.toWeather())
            }
        }
        
        return weathers
    }
}
