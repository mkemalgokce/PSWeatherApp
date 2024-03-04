//
//  RemoteWithLocalFallbackWeatherLoader.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

final class RemoteWithLocalFallbackWeatherLoader: WeatherLoader {
    private let localLoader: LocalWeatherLoader
    private let remoteLoader: RemoteWeatherLoader
    
    init(localLoader: LocalWeatherLoader, remoteLoader: RemoteWeatherLoader) {
        self.localLoader = localLoader
        self.remoteLoader = remoteLoader
    }
    
    func load(completion: @escaping (LoadWeatherResult) -> Void) {
        remoteLoader.load { [weak self] result in
            guard let self else { return }
            switch result {
                case .success(let result):
                    do {
                        try localLoader.save(result)
                        completion(.success(result))
                    }catch {
                        completion(.failure(error))
                    }
                case .failure(_):
                    localLoader.load { localResult in
                        completion(localResult)
                    }
            }
        }
    }
    
}
