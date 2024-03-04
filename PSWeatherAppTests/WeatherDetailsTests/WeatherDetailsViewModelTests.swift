//
//  WeatherDetailsViewModelTests.swift
//  PSWeatherAppTests
//
//  Created by Mustafa Kemal Gökçe on 4.03.2024.
//

import XCTest
@testable import PSWeatherApp

class WeatherDetailViewModelTests: XCTestCase {
    
    private var viewModel: WeatherDetailViewModel!
    private var favouriteManager: MockFavouriteManager!
    private var weather: Weather!
    
    override func setUpWithError() throws {
        favouriteManager = MockFavouriteManager()
        weather = anyWeather()
        viewModel = WeatherDetailViewModel(weather: weather, favouriteManager: favouriteManager)
    }
    
    override func tearDownWithError() throws {
        favouriteManager = nil
        viewModel = nil
        weather = nil
    }
    
    func test_forecastCount() {
        let expectedCount = 0
        XCTAssertEqual(viewModel.foreCastCount, expectedCount)
    }
    
    func test_isInFavourite() {
        XCTAssertFalse(viewModel.isInFavourite)
    }
    
    func test_addToFavouritesSuccess() {
        let expectation = self.expectation(description: "Add to favourites successful")
        
        viewModel.addToFavourites()
        
        XCTAssertEqual(favouriteManager.savedWeather, weather)
        XCTAssertTrue(viewModel.isInFavourite)
        expectation.fulfill()
        

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    private class MockFavouriteManager: FavouriteManagerProtocol {
        var savedWeather: Weather?
        var mockIsInStoreResult: Bool = false
        
        func save(weather: Weather) throws {
            savedWeather = weather
        }
        
        func delete(weather: Weather) throws {
            savedWeather = nil
        }
        
        func isInStore(_ weather: Weather) throws -> Bool {
            savedWeather == weather
        }
        
        func load(completion: @escaping (Result<[PSWeatherApp.Weather], Error>) -> Void) {
            
        }
    }
    
}



