//
//  ForecastEntity+CoreDataProperties.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//
//

import Foundation
import CoreData


extension ForecastEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastEntity> {
        return NSFetchRequest<ForecastEntity>(entityName: "ForecastEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: Int16
    @NSManaged public var temperature: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var wind_speed: Int16
    @NSManaged public var weather_description: String?
    @NSManaged public var weather: WeatherEntity?

}

extension ForecastEntity : Identifiable {

}
