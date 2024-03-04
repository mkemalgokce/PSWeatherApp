//
//  PSWeatherLoaderAPIEndToEndTests.swift
//  PSWeatherLoaderAPIEndToEndTests
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import XCTest
@testable import PSWeatherApp

final class PSWeatherEngineAPIEndToEndTests: XCTestCase {
    private static var weathers: [Weather]?
    
    override class func setUp() {
        super.setUp()
        weathers = decodeWeatherJSON()
    }
    
    func test_endToEndTestServerGETWeatherResult() {
        switch getWeatherResult() {
            case let .success(items):
                XCTAssertEqual(items.count, 51, "Expected 51 items in the url")
                items.enumerated().forEach { (index, item) in
                    XCTAssertEqual(item, expectedItem(at: index), "Unexpected item values at index \(index)")
                }
            case let .failure(error):
                XCTFail("Expected success result, got \(error) instead")
            default:
                XCTFail("Expected successfull weather result, got no result instead")
        }
    }
    
    // MARK: - Helpers
    private func getWeatherResult(file: StaticString = #filePath,
                               line: UInt = #line) -> RemoteWeatherLoader.Result? {
        let testServerURL = URL(string: "https://freetestapi.com/api/v1/weathers")!
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let loader = RemoteWeatherLoader(url: testServerURL, client: client)
        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(loader, file: file, line: line)
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: RemoteWeatherLoader.Result? = nil
        loader.load { result in
            receivedResult = result
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5.0)
        return receivedResult
    }
    
    private func expectedItem(at index: Int) -> Weather? {
        Self.weathers?[index]
    }
    
    static func decodeWeatherJSON() -> [Weather]? {
        let fileName = "response"
        guard let pathString = Bundle(for: self).path(forResource: fileName, ofType: "json") else {
            fatalError("\(fileName) not found")
        }

        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert \(fileName).json to String")
        }

        print("The JSON string is: \(jsonString)")

        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert \(fileName).json to Data")
        }

        return try? JSONDecoder().decode([Weather].self, from: jsonData)
    }
}
