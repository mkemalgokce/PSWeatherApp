//
//  CoreDataWeatherStore.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation
import CoreData

final class CoreDataWeatherStore: WeatherStore {
    
    enum Error: Swift.Error {
        case cacheNotFound
    }
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WeatherDataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        return container
    }()
    
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    
    func deleteCachedWeather() throws {
        try context.performAndWait {
            let cacheEntities = try context.fetch(CacheEntity.fetchRequest())
            
            for cacheEntity in cacheEntities {
                guard let weathers = cacheEntity.weather else { continue }
                for weather in weathers {
                    if let weatherEntity = weather as? WeatherEntity {
                        try WeatherEntity.delete(weatherEntity, context: context)
                    }
                }
            }
            
            try context.save()
        }
        
    }
    
    func insert(_ weathers: [Weather], timestamp: Date) throws {
        
        try context.performAndWait {
            let cache = CacheEntity(context: context)
            cache.timestamp = timestamp
            
            for weather in weathers {
                cache.addToWeather(WeatherEntity.create(from: weather, context: context))
            }
            
            try context.save()
        }
        
    }
    
    func retrieve() throws -> CachedWeather? {
        let fetchRequest: NSFetchRequest<CacheEntity> = CacheEntity.fetchRequest()
        
        let result = try context.fetch(fetchRequest)
        
        if let first = result.first {
            return first.toCachedWeather()
        }
        
        return nil
    }
    
}
