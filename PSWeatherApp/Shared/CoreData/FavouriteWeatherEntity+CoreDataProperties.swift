//
//  FavouriteWeatherEntity+CoreDataProperties.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//
//

import Foundation
import CoreData


extension FavouriteWeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteWeatherEntity> {
        return NSFetchRequest<FavouriteWeatherEntity>(entityName: "FavouriteWeatherEntity")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var humidity: Int16
    @NSManaged public var id: Int16
    @NSManaged public var temperature: Double
    @NSManaged public var weather_description: String?
    @NSManaged public var wind_speed: Double
    @NSManaged public var favourite: FavouritesEntity?
    @NSManaged public var forecast: NSSet?

}

// MARK: Generated accessors for forecast
extension FavouriteWeatherEntity {

    @objc(addForecastObject:)
    @NSManaged public func addToForecast(_ value: FavouriteForecastEntity)

    @objc(removeForecastObject:)
    @NSManaged public func removeFromForecast(_ value: FavouriteForecastEntity)

    @objc(addForecast:)
    @NSManaged public func addToForecast(_ values: NSSet)

    @objc(removeForecast:)
    @NSManaged public func removeFromForecast(_ values: NSSet)

}

extension FavouriteWeatherEntity : Identifiable {

}
