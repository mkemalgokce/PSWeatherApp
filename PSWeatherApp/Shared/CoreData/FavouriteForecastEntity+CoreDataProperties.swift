//
//  FavouriteForecastEntity+CoreDataProperties.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//
//

import Foundation
import CoreData


extension FavouriteForecastEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteForecastEntity> {
        return NSFetchRequest<FavouriteForecastEntity>(entityName: "FavouriteForecastEntity")
    }

    @NSManaged public var date: String?
    @NSManaged public var humidity: Int16
    @NSManaged public var id: Int16
    @NSManaged public var temperature: Double
    @NSManaged public var weather_description: String?
    @NSManaged public var wind_speed: Double
    @NSManaged public var weather: FavouriteWeatherEntity?

}

extension FavouriteForecastEntity : Identifiable {

}
