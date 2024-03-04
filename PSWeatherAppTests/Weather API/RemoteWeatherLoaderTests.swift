//
//  RemoteWeatherLoaderTests.swift
//  PSWeatherAppTests
//
//  Created by Mustafa Kemal Gökçe on 4.03.2024.
//

import XCTest
@testable import PSWeatherApp

final class RemoteWeatherLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestWithoutLoad() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsFromURL() {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_load_requstsFromURL_twice() {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.connectivity), when: {
            client.complete(with: anyNSError())
        })
    }
    
    func test_load_deliversInvalidDataErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: failure(.invalidData), when: {
                let data = anyData()
                client.complete(withStatusCode: code, data: data, at: index)
            })
        }
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.invalidData), when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }
    
    func test_load_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .success([]), when: {
            let emptyJSONList = "[]"
            client.complete(withStatusCode: 200, data: Data(emptyJSONList.utf8))
        })
    }
    
    func test_load_deliversOneItemOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()
        
        let generated = generateWeathersData()
        
        expect(sut, toCompleteWith: .success(generated.weathers), when: {
            client.complete(withStatusCode: 200, data: generated.data)
        })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = anyURL()
        let client = HTTPClientSpy()
        var sut: RemoteWeatherLoader? = RemoteWeatherLoader(url: url, client: client)
        
        var capturedResults: [RemoteWeatherLoader.Result] = []
        sut?.load { capturedResults.append($0) }
        
        sut = nil
        
        client.complete(withStatusCode: 200, data: generateWeathersData().data)
        XCTAssertTrue(capturedResults.isEmpty)
    }
    
    // MARK: - Helpers
    private func makeSUT(url: URL? = nil,
                         file: StaticString = #filePath,
                         line: UInt = #line) -> (sut: RemoteWeatherLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteWeatherLoader(url: url ?? anyURL(), client: client)
        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, client)
    }
    
    private func makeWeathersJSON(_ items: [[String: Any]]) -> Data {
        let json = ["items": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func expect(_ sut: RemoteWeatherLoader, toCompleteWith expectedResult: RemoteWeatherLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
                case let (.success(receivedItems), .success(expectedItems)):
                    XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
                    
                case let (.failure(receivedError as RemoteWeatherLoader.Error), .failure(expectedError as RemoteWeatherLoader.Error)):
                    XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                    
                default:
                    XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL,
                                 completion: (HTTPClient.Result) -> Void)]()
        var requestedURLs: [URL] {
            messages.map { $0.url }
        }
        
        func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> PSWeatherApp.HTTPClientTask {
            messages.append((url, completion))
            return MockTask()
        }
       
        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            messages[index].completion(.success((data, response)))
        }
    }
    
    private class MockTask: HTTPClientTask {
        func cancel() {
            
        }
    }
    
    private func anyWeather() -> Weather {
        
        Weather(id: Int.random(in: 0..<50),
                city: "TR",
                country: "Istanbul",
                temperature: Double.random(in: 0..<12),
                weatherDescription: .random() ,
                humidity: Int.random(in: 0..<50),
                windSpeed: Double.random(in: 0..<12),
                forecast: [])
        
    }
    
    private func generateWeathersData() -> (weathers: [Weather], data: Data) {
        let weathers: [Weather] = [anyWeather(), anyWeather()]
        let data = try! JSONEncoder().encode(weathers)
        
        return (weathers, data)
    }
    
    private func failure(_ error: RemoteWeatherLoader.Error) -> RemoteWeatherLoader.Result {
        return .failure(error)
    }
}
