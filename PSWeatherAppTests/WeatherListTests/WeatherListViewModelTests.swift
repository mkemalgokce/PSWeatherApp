//
//  WeatherListViewModelTests.swift
//  PSWeatherAppTests
//
//  Created by Mustafa Kemal Gökçe on 4.03.2024.
//

import XCTest
@testable import PSWeatherApp


class WeatherListViewModelTests: XCTestCase {
    
    var weatherLoader: MockWeatherLoader!
    var favouriteManager: MockFavouriteManager!
    var viewModel: WeatherListViewModel!
    
    override func setUpWithError() throws {
        weatherLoader = MockWeatherLoader()
        favouriteManager = MockFavouriteManager()
        viewModel = WeatherListViewModel(weatherLoader: weatherLoader, favouriteManager: favouriteManager)
    }
    
    override func tearDownWithError() throws {
        weatherLoader = nil
        favouriteManager = nil
        viewModel = nil
    }
    
    func test_fetchWeatherDataSuccess() {
        let expectedWeather = [anyWeather()]
        weatherLoader.mockResult = .success(expectedWeather)
        
        viewModel.fetch()
        
        XCTAssertTrue(viewModel.itemCount(isFiltering: false) == 1)
        XCTAssertEqual(viewModel.weather(at: IndexPath(item: 0, section: 0)), expectedWeather[0])
    }
    
    func test_fetchWeatherDataFailure() {
        let expectedError = NSError(domain: "Test", code: 123, userInfo: nil)
        weatherLoader.mockResult = .failure(expectedError)
        
        viewModel.fetch()
        
        XCTAssertEqual(viewModel.itemCount(isFiltering: false), 0)
    }
    
    func test_addToFavouritesSuccess() {
        let weather = anyWeather()
        
        viewModel.addWeatherToFavourites(weather)

        XCTAssertEqual(favouriteManager.savedWeather, weather)
    }
    
    func test_loadWeatherDataSuccess() {
        let expectation = self.expectation(description: "Load weather data successful")
        var loadedWeathers: [Weather]?
        
        weatherLoader.mockResult = .success([])
        
        weatherLoader.load { result in
            switch result {
                case .success(let weathers):
                    loadedWeathers = weathers
                case .failure(let error):
                    XCTFail("Load weather data failed with error: \(error)")
            }
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertNotNil(loadedWeathers)
    }
    
    func test_isInStore() {
        let weather = anyWeather()
        let expectedResult = false
        do {
            let result = try favouriteManager.isInStore(weather)
            XCTAssertEqual(result, expectedResult)
        } catch {
            XCTFail("isInStore threw an unexpected error: \(error)")
        }
    }
}

class MockWeatherLoader: WeatherLoader {
    var mockResult: Result<[Weather], Error>?
    
    func load(completion: @escaping (Result<[Weather], Error>) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
}

class MockFavouriteManager: FavouriteManagerProtocol {
    var savedWeather: Weather?
    
    func save(weather: Weather) throws {
        savedWeather = weather
    }
    
    func delete(weather: Weather) throws {
        savedWeather = nil
    }
    
    func load(completion: @escaping (Result<[PSWeatherApp.Weather], Error>) -> Void) {
        
    }
    
    func isInStore(_ weather: PSWeatherApp.Weather) throws -> Bool {
        savedWeather == weather
    }
}

