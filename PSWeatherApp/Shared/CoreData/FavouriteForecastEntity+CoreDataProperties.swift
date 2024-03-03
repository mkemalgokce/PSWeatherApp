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
    func toForecast() -> Forecast {
            guard let date, let weather_description, let weatherDescription = WeatherDescription(rawValue: weather_description) else { fatalError("Error on converting forecast entity to forecast!") }
            return Forecast(date: date, temperature: Int(temperature), weatherDescription: weatherDescription, humidity: Int(humidity), windSpeed: wind_speed)
        }
        
        static func create(from forecast: Forecast, context: NSManagedObjectContext) -> FavouriteForecastEntity {
            let forecastEntity = FavouriteForecastEntity(context: context)
            forecastEntity.date = forecast.date
            forecastEntity.temperature = Double(forecast.temperature)
            forecastEntity.humidity = Int16(forecast.humidity)
            forecastEntity.wind_speed = forecast.windSpeed
            forecastEntity.weather_description = forecast.weatherDescription.rawValue
            
            return forecastEntity
        }
}
