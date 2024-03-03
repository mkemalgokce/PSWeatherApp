//
//  CacheEntity+CoreDataProperties.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//
//

import Foundation
import CoreData


extension CacheEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheEntity> {
        return NSFetchRequest<CacheEntity>(entityName: "CacheEntity")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var weather: NSSet?

}

// MARK: Generated accessors for weather
extension CacheEntity {

    @objc(addWeatherObject:)
    @NSManaged public func addToWeather(_ value: WeatherEntity)

    @objc(removeWeatherObject:)
    @NSManaged public func removeFromWeather(_ value: WeatherEntity)

    @objc(addWeather:)
    @NSManaged public func addToWeather(_ values: NSSet)

    @objc(removeWeather:)
    @NSManaged public func removeFromWeather(_ values: NSSet)

}

extension CacheEntity : Identifiable {
    func toCachedWeather() -> WeatherWithTimestamp {
        guard let timestamp, let weather else { fatalError("Error on casting Cache Entity") }
        var weathers: [Weather] = []
        for entity in weather {
            if let weatherEntity = entity as? WeatherEntity {
                weathers.append(weatherEntity.toWeather())
            }
        }
        
        return (weathers, timestamp)
    }
}
