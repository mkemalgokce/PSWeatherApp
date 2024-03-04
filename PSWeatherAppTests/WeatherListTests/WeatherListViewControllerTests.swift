//
//  WeatherListViewControllerTests.swift
//  PSWeatherAppTests
//
//  Created by Mustafa Kemal Gökçe on 4.03.2024.
//

import XCTest
@testable import PSWeatherApp

class WeatherListViewControllerTests: XCTestCase {
    
    var viewController: WeatherListViewController!
    var viewModel: WeatherListViewModel!
    var weatherLoader: MockWeatherLoader!
    
    override func setUpWithError() throws {
        weatherLoader = MockWeatherLoader()
        viewModel = WeatherListViewModel(weatherLoader: weatherLoader)
        viewController = WeatherListViewController(viewModel: viewModel)
        viewController.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        viewController = nil
        viewModel = nil
    }
    
    func test_tableViewDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource)
        XCTAssertTrue(viewController.tableView.dataSource is WeatherListViewController)
    }
    
    func test_tableViewDelegate() {
        XCTAssertNotNil(viewController.tableView.delegate)
        XCTAssertTrue(viewController.tableView.delegate is WeatherListViewController)
    }
    
    func test_tableViewHasCells() {
        let cell = viewController.tableView.dequeueReusableCell(withIdentifier: WeatherListCell.identifier)
        XCTAssertNotNil(cell)
    }
    
    func test_tableViewCellCount_withNoItems() {
        weatherLoader.mockResult = .success([])
        
        viewModel.fetch()
        
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_tableViewCellCount_withTwoItems() {
        weatherLoader.mockResult = .success([anyWeather(), anyWeather()])
        
        viewModel.fetch()
        
        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_tableViewCell() {
        let weathers = [anyWeather(), anyWeather(), anyWeather()]
        let tableView = viewController.tableView
        weatherLoader.mockResult = .success(weathers)
        
        viewModel.fetch()
       
        for (i,visibleCell) in tableView.visibleCells.enumerated() {
            let cell = cell(on: index(i), from: tableView)
            let weather = weathers[i]
            
            XCTAssertEqual(cell?.cityLabel.text, weather.city)
            XCTAssertEqual(cell?.countryLabel.text, weather.country)
            XCTAssertEqual(cell?.weatherDescriptionLabel.text, weather.weatherDescription.rawValue.capitalizedFirstLetterOfEachWord())
            XCTAssertEqual(cell?.humidityInfoView.text, String(weather.humidity))
            XCTAssertEqual(cell?.windSpeedInfoView.text, String(weather.windSpeed))
            XCTAssertEqual(cell?.temperatureLabel.text, String(weather.temperature))
        }
    }
    
    // MARK: Helpers
    private func cell(on indexPath: IndexPath, from tableView: UITableView) -> WeatherListCell? {
        return tableView.cellForRow(at: indexPath) as? WeatherListCell
    }
    
    private func index(_ index: Int) -> IndexPath {
        IndexPath(row: index, section: 0)
    }
    
}
