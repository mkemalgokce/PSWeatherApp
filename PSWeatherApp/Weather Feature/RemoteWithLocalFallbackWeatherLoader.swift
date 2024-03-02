//
//  RemoteWithLocalFallbackWeatherLoader.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

final class RemoteWithLocalFallbackWeatherLoader: WeatherLoader {
    private let localLoader: WeatherLoader
    private let remoteLoader: WeatherLoader
    
    init(localLoader: WeatherLoader, remoteLoader: WeatherLoader) {
        self.localLoader = localLoader
        self.remoteLoader = remoteLoader
    }
    
    func load(completion: @escaping (LoadWeatherResult) -> Void) {
        remoteLoader.load { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let result):
                    completion(.success(result))
                case .failure(_):
                    localLoader.load { result in completion(result) }
            }
        }
    }

}
