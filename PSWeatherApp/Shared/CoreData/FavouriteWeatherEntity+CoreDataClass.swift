//
//  FavouriteWeatherEntity+CoreDataClass.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//
//

import Foundation
import CoreData

@objc(FavouriteWeatherEntity)
public class FavouriteWeatherEntity: NSManagedObject {
    func toWeather() -> Weather {
            guard let city,
                  let country,
                  let weather_description,
                  let forecast,
                  let weatherDescription = WeatherDescription(rawValue: weather_description)
            else { fatalError("Error on converting Weather Entity to Weather ")}
            
            var forecasts: [Forecast] = []
            for forecastEntity in forecast {
                if let cast = forecastEntity as? FavouriteForecastEntity {
                    forecasts.append(cast.toForecast())
                }
            }
            
            return Weather(id: Int(id),
                           city: city, country: country, temperature: Double(temperature), weatherDescription: weatherDescription, humidity: Int(humidity), windSpeed: wind_speed, forecast: forecasts)
        }
        
        static func create(from weather: Weather, context: NSManagedObjectContext) -> FavouriteWeatherEntity {
            let weatherEntity = FavouriteWeatherEntity(context: context)
            weatherEntity.temperature = weather.temperature
            weatherEntity.humidity = Int16(weather.humidity)
            weatherEntity.id = Int16(weather.id)
            weatherEntity.weather_description = weather.weatherDescription.rawValue
            weatherEntity.city = weather.city
            weatherEntity.country = weather.country
            weatherEntity.wind_speed = weather.windSpeed
            
            var forecastEntities: [FavouriteForecastEntity] = []
            for forecast in weather.forecast {
                forecastEntities.append(FavouriteForecastEntity.create(from: forecast, context: context))
            }
            
            weatherEntity.forecast = NSSet(array: forecastEntities)
            
            return weatherEntity
        }
        
        static func delete(_ entity: FavouriteWeatherEntity, context: NSManagedObjectContext) throws {
            guard let forecasts = entity.forecast else { return }
            for forecastEntities in forecasts {
                if let forecast = forecastEntities as? FavouriteWeatherEntity {
                    context.delete(forecast)
                }
            }
            context.delete(entity)
        }
}
