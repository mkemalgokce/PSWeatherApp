//
//  WeatherListViewController.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import UIKit

final class WeatherListViewController: UIViewController {
    private let viewModel: WeatherListViewModel
    private let weatherListView = WeatherListView()
    
    var tableView: UITableView  {
        weatherListView.tableView
    }
    
    private var searchController: UISearchController  {
        weatherListView.searchController
    }
    
    override func loadView() {
        view = weatherListView

    }
    
    init(viewModel: WeatherListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupTableView()
        setupSearchController()
        viewModel.delegate = self
        viewModel.fetch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Weathers"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode =  .always
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSearchController() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func presentWeatherDetails(_ weather: Weather) {
        let viewModel = WeatherDetailViewModel(weather: weather, favouriteManager: FavouriteWeatherManager.shared)
        let viewController = WeatherDetailsViewController(viewModel: viewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func addToFavourites(_ indexPath: IndexPath) {
        let weather = viewModel.weather(at: indexPath)
        viewModel.addWeatherToFavourites(weather)
    }
    
}

// MARK: - UITableViewDatasource & UITableViewDelegate
extension WeatherListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemCount(isFiltering: isFiltering())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.identifier, for: indexPath) as? WeatherListCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.item(isFiltering: isFiltering(), at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weather = viewModel.item(isFiltering: isFiltering(), at: indexPath)
        presentWeatherDetails(weather)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.bounds.height
            
            if offsetY > contentHeight - height {
                viewModel.goToNextPage()
                tableView.reloadData()
            }
        }
}


// MARK: - WeatherListViewModelDelegate methods
extension WeatherListViewController: WeatherListViewModelDelegate {
    func didStartLoading() {
        showLoader()
    }
    
    func didAddToFavourite() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoader()
        }
    }
    
    func didFailToAddFavourite(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoader { [weak self] in
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func didRemoveToFavourite() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoader()
        }
    }
    
    func didFailToRemoveFavourite(_ error: Error) {
        
        DispatchQueue.main.async { [weak self] in
            self?.hideLoader { [weak self] in
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }

    }
    
    func didFetchWeathers() {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoader { [weak self] in
                self?.tableView.reloadData()
            }
            
        }
    }
    
    func didFailToFetchWeathersData(_ error: Error) {
        hideLoader { [weak self] in
            self?.showAlertOnMainThread(title: "Error", message: error.localizedDescription)
        }
       
    }
    
}

// MARK: - UISearchControllerDelegate methods
extension WeatherListViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    func filterContentForSearchText(_ searchText: String) {
        viewModel.filter(with: searchText)
        tableView.reloadData()
    }
    
    
}
