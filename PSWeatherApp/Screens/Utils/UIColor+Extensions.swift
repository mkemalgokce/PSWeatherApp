//
//  UIColor+Extensions.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 4.03.2024.
//

import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 0.5)
    }
}
