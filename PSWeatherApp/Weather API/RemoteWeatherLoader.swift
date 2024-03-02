//
//  RemoteWeatherLoader.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

final class RemoteWeatherLoader: WeatherLoader {
    private let url: URL
    private let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    enum Error: Swift.Error {
        case invalidData
        case connectivity
    }
    
    func load(completion: @escaping (LoadWeatherResult) -> Void) {
        
    }
}
