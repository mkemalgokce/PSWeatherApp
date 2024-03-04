//
//  Error+Utils.swift
//  PSWeatherLoaderTests
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import Foundation

extension Error {
    func getErrorWithoutUserInfo() -> Error {
        let nsError = self as NSError
        
        return NSError(domain: nsError.domain, code: nsError.code)
    }
}
