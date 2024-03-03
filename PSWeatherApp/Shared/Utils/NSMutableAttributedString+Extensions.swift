//
//  NSMutableAttributedString+Extensions.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import Foundation

extension NSMutableAttributedString {
    convenience init(strings: [NSAttributedString]) {
        self.init()
        for string in strings {
            append(string)
        }
    }
}
