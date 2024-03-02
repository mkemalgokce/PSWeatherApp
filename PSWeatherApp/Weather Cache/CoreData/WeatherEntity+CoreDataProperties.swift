//
//  WeatherEntity+CoreDataProperties.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var temperature: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var id: Int16
    @NSManaged public var timestamp: Date?
    @NSManaged public var weather_description: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var forecast: NSSet?

}

// MARK: Generated accessors for forecast
extension WeatherEntity {

    @objc(addForecastObject:)
    @NSManaged public func addToForecast(_ value: ForecastEntity)

    @objc(removeForecastObject:)
    @NSManaged public func removeFromForecast(_ value: ForecastEntity)

    @objc(addForecast:)
    @NSManaged public func addToForecast(_ values: NSSet)

    @objc(removeForecast:)
    @NSManaged public func removeFromForecast(_ values: NSSet)

}

extension WeatherEntity : Identifiable {

}
