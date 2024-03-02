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
    
    typealias Result = LoadWeatherResult
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    enum Error: Swift.Error {
        case invalidData
        case connectivity
    }
    
    func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success((let data, let response)):
                    completion(Self.map(data, from: response))
                case .failure:
                    completion(.failure(Error.connectivity))
            }
        }
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let weathers = try WeatherItemsMapper.map(data, from: response)
            return .success(weathers)
        } catch {
            return .failure(error)
        }
    }
}
