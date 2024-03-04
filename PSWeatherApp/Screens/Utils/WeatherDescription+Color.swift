//
//  WeatherDescription+Color.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

extension WeatherDescription {
    func color() -> UIColor {
        switch self {
            case .clearSky:
                return .clearSky
            case .cloudy:
                return .cloudy
            case .partlyCloudy:
                return .partlyCloudy
            case .rain:
                return .rain
            case .rainShowers:
                return .rainShowers
            case .rainy:
                return .rainy
            case .scatteredClouds:
                return .scatteredClouds
            case .sunny:
                return .sunny
            case .weatherDescriptionPartlyCloudy:
                return .partlyCloudy
        }
    }
    
    func image() -> UIImage {
        switch self {
            case .clearSky:
                return .cloudSun
            case .cloudy:
                return .cloudFill
            case .partlyCloudy:
                return .partlyCloud
            case .rain:
                return .rain
            case .rainShowers:
                return .rainShowers
            case .rainy:
                return .rain
            case .scatteredClouds:
                return .scatteredClouds
            case .sunny:
                return .sun
            case .weatherDescriptionPartlyCloudy:
                return .partlyCloud
        }
    }
    
    func textColor() -> UIColor {
        switch self {
            case .sunny:
                return .unselected
            default:
                return .customTitle
        }
    }
    
    func tintColor() -> UIColor {
        switch self {
            case .sunny:
                return .unselected
            default:
                return .customSecond
        }
    }
}
