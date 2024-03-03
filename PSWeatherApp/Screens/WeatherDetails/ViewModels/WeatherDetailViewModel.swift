//
//  WeatherDetailViewModel.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import Foundation

final class WeatherDetailViewModel {
    var weather: Weather
    
    var title: String {
        "\(weather.country) / \(weather.city)"
    }
    
    var foreCastCount: Int {
        weather.forecast.count
    }
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    func favourite() {
        
    }
    
    func forecast(at index: IndexPath) -> Forecast {
        weather.forecast[index.item]
    }
    
}
