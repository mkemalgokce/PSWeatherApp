//
//  FavouritesViewModelTests.swift
//  PSWeatherAppTests
//
//  Created by Mustafa Kemal Gökçe on 4.03.2024.
//

import XCTest
@testable import PSWeatherApp

class FavouritesViewModelTests: XCTestCase {
    
    private var viewModel: FavouritesViewModel!
    private var favouriteManager: MockFavouriteManager!
    
    override func setUpWithError() throws {
        favouriteManager = MockFavouriteManager()
        viewModel = FavouritesViewModel(favouriteManager: favouriteManager)
    }
    
    override func tearDownWithError() throws {
        favouriteManager = nil
        viewModel = nil
    }
    
    func testFetchWeatherDataSuccess() {
        // Setup
        let expectation = self.expectation(description: "Fetch weather data successful")
        let expectedWeathers = [anyWeather()]
        favouriteManager.mockLoadResult = .success(expectedWeathers)
        
        viewModel.fetch()
        
        XCTAssertTrue(viewModel.itemCount == 1)
        XCTAssertEqual(viewModel.weather(at: IndexPath(item: 0, section: 0)), expectedWeathers[0])
        expectation.fulfill()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchWeatherDataFailure() {
        
        let expectation = self.expectation(description: "Fetch weather data failed")
        let expectedError = NSError(domain: "Test", code: 123, userInfo: nil)
        favouriteManager.mockLoadResult = .failure(expectedError)
        
        viewModel.fetch()
        
        XCTAssertEqual(viewModel.itemCount, 0)
        expectation.fulfill()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    private class MockFavouriteManager: FavouriteManagerProtocol {
        var mockLoadResult: Result<[Weather], Error>?
        
        func load(completion: @escaping (Result<[Weather], Error>) -> Void) {
            if let result = mockLoadResult {
                completion(result)
            }
        }
        
        func save(weather: Weather) throws {}
        
        func delete(weather: Weather) throws {}
        
        func isInStore(_ weather: Weather) throws -> Bool {
            return false
        }
    }
    
}
