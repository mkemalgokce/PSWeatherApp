//
//  FavouriteWeatherLoader.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import Foundation

protocol FavouriteManagerProtocol {
    func load(completion: @escaping(Result<[Weather], Error>) -> Void)
    func save(weather: Weather) throws
    func delete(weather: Weather) throws
    
    func isInStore(_ weather: Weather) throws -> Bool
}

final class FavouriteWeatherManager: FavouriteManagerProtocol {

    
    private var store: FavouriteStore?
    static let shared = FavouriteWeatherManager()
    
    enum Error: Swift.Error {
        case emptyStore
    }
    
    private init() {}
        
    func addStore(_ store: FavouriteStore) {
        self.store = store
    }

    func load(completion: @escaping (Result<[Weather], Swift.Error>) -> Void) {
        guard let store else { return completion(.failure(Error.emptyStore)) }
        do {
            let weathers = try store.retrieve()
            completion(.success(weathers))
        }catch {
            completion(.failure(error))
        }
    }
    
    func save(weather: Weather) throws {
        guard let store else { throw Error.emptyStore }
        try store.saveFavourite(weather)
    }
    
    func delete(weather: Weather) throws {
        guard let store else { throw Error.emptyStore }
        try store.deleteFavourite(weather)
    }
    
    func isInStore(_ weather: Weather) throws -> Bool {
        guard let store else { throw Error.emptyStore }
        return try store.find(weather)
    }
}

