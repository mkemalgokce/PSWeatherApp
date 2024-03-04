//
//  XCTestCase+TestingUtils.swift
//  PSWeatherLoaderTests
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import XCTest


extension XCTestCase {
    func anyURL() -> URL { URL(string: "https://any-url.com")! }
    func anyData() -> Data { Data("any data".utf8) }
    func anyNSError() -> NSError { NSError(domain: "any", code: -1) }
    func anyHTTPURLResponse() -> HTTPURLResponse { HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)! }
    func nonHTTPURLResponse() -> URLResponse { URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil) }
}
