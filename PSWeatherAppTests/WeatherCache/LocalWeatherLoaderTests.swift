//
//  LocalWeatherLoaderTests.swift
//  PSWeatherAppTests
//
//  Created by Mustafa Kemal Gökçe on 4.03.2024.
//

import XCTest
@testable import PSWeatherApp

class LocalWeatherLoaderTests: XCTestCase {
    
    func test_init_doesNotMessageStoreUponCreation() {
        let (_, store) = makeSUT()

        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_load_requestsCacheRetrieval() {
        let items = [anyWeather(), anyWeather()]
        let (sut, store) = makeSUT()

        sut.load { _ in }
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_load_failsOnRetrievalError() {
            let (sut, store) = makeSUT()
            let retrievalError = anyNSError()
            
            expect(sut, toCompleteWith: .failure(retrievalError), when: {
                store.completeRetrieval(with: retrievalError)
            })
        }
    
    func test_load_deliversNoWeathersOnEmptyCache() {
            let (sut, store) = makeSUT()
            
            expect(sut, toCompleteWith: .success([]), when: {
                store.completeRetrievalWithEmptyCache()
            })
        }
    
    func test_load_deliversCachedWeathersOnNonExpiredCache() {
            let weather = generateWeathersData()
            let fixedCurrentDate = Date()
        let nonExpiredTimestamp = fixedCurrentDate.minusWeatherCacheMaxAge().adding(seconds: 1)
            let (sut, store) = makeSUT(currentDate: { fixedCurrentDate })
            
        expect(sut, toCompleteWith: .success(weather.weathers), when: {
                store.completeRetrieval(with: weather.weathers, timestamp: nonExpiredTimestamp)
            })
        }
    

    
    // MARK: - Helpers
    
    private func makeSUT(currentDate: @escaping () -> Date = Date.init, file: StaticString = #file, line: UInt = #line) -> (sut: LocalWeatherLoader, store: WeatherStoreSpy) {
        let store = WeatherStoreSpy()
        let sut = LocalWeatherLoader(store: store, currentDate: currentDate)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalWeatherLoader, toCompleteWith expectedResult: Result<[Weather], Error>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
            action()

        var receivedResult: Result<[Weather], Error>? = nil
        
        sut.load { receivedResult = $0 }
            
            switch (receivedResult, expectedResult) {
            case let (.success(receivedImages), .success(expectedImages)):
                XCTAssertEqual(receivedImages, expectedImages, file: file, line: line)
                
            case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
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
    
    private class WeatherStoreSpy: WeatherStore {
        
        enum ReceivedMessage: Equatable {
            case deleteCachedWeather
            case insert([Weather], Date)
            case retrieve
        }
        
        private(set) var receivedMessages = [ReceivedMessage]()
        
        private var deletionResult: Result<Void, Error>?
        private var insertionResult: Result<Void, Error>?
        private var retrievalResult: Result<WeatherWithTimestamp, Error>?
        
        func deleteWeather() throws {
            receivedMessages.append(.deleteCachedWeather)
            try deletionResult?.get()
        }
        
        func completeDeletion(with error: Error) {
            deletionResult = .failure(error)
        }
        
        func completeDeletionSuccessfully() {
            deletionResult = .success(())
        }
        
        func insert(_ weather: [Weather], timestamp: Date) throws {
            receivedMessages.append(.insert(weather, timestamp))
            try insertionResult?.get()
        }
        
        func completeInsertion(with error: Error) {
            insertionResult = .failure(error)
        }
        
        func completeInsertionSuccessfully() {
            insertionResult = .success(())
        }
        
        func retrieve() throws -> WeatherWithTimestamp? {
            receivedMessages.append(.retrieve)
            return try retrievalResult?.get()
        }
        
        func completeRetrieval(with error: Error) {
            retrievalResult = .failure(error)
        }
        
        func completeRetrievalWithEmptyCache() {
            retrievalResult = .success(([], Date()))
        }
        
        func completeRetrieval(with weather: [Weather], timestamp: Date) {
            retrievalResult = .success(WeatherWithTimestamp(weather, timestamp))
        }
    }
    
}
