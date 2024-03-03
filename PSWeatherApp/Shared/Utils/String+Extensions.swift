//
//  String+Extensions.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import Foundation

extension String {
    func capitalizedFirstLetterOfEachWord() -> String {
        let words = components(separatedBy: " ")
        let capitalizedWords = words.map { $0.prefix(1).capitalized + $0.dropFirst() }
        return capitalizedWords.joined(separator: " ")
    }
    
    func toDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
