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

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var humidity: Int16
    @NSManaged public var id: Int16
    @NSManaged public var temperature: Double
    @NSManaged public var weather_description: String?
    @NSManaged public var wind_speed: Double
    @NSManaged public var cache: CacheEntity?
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
    func toWeather() -> Weather {
            guard let city,
                  let country,
                  let weather_description,
                  let forecast,
                  let weatherDescription = WeatherDescription(rawValue: weather_description)
            else { fatalError("Error on converting Weather Entity to Weather ")}
            
            var forecasts: [Forecast] = []
            for forecastEntity in forecast {
                if let cast = forecastEntity as? ForecastEntity {
                    forecasts.append(cast.toForecast())
                }
            }
            
            return Weather(id: Int(id),
                           city: city, country: country, temperature: Double(temperature), weatherDescription: weatherDescription, humidity: Int(humidity), windSpeed: wind_speed, forecast: forecasts)
        }
        
        static func create(from weather: Weather, context: NSManagedObjectContext) -> WeatherEntity {
            let weatherEntity = WeatherEntity(context: context)
            weatherEntity.temperature = weather.temperature
            weatherEntity.humidity = Int16(weather.humidity)
            weatherEntity.id = Int16(weather.id)
            weatherEntity.weather_description = weather.weatherDescription.rawValue
            weatherEntity.city = weather.city
            weatherEntity.country = weather.country
            weatherEntity.wind_speed = weather.windSpeed
            
            var forecastEntities: [ForecastEntity] = []
            for forecast in weather.forecast {
                forecastEntities.append(ForecastEntity.create(from: forecast, context: context))
            }
            
            weatherEntity.forecast = NSSet(array: forecastEntities)
            
            return weatherEntity
        }
        
        static func delete(_ entity: WeatherEntity, context: NSManagedObjectContext) throws {
            guard let forecasts = entity.forecast else { return }
            for forecastEntities in forecasts {
                if let forecast = forecastEntities as? ForecastEntity {
                    context.delete(forecast)
                }
            }
            context.delete(entity)
        }
}
