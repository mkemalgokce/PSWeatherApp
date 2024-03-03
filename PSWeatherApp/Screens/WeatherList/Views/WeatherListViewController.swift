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
    
    private var tableView: UITableView  {
        weatherListView.tableView
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
        viewModel.delegate = self
        viewModel.fetch()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDatasource & UITableViewDelegate
extension WeatherListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.identifier, for: indexPath) as? WeatherListCell
        else {
            fatalError("Invaid cell")
        }
        cell.configure(with: viewModel.weather(at: indexPath))
        return cell
    }
    
    
}


// MARK: - WeatherListViewModelDelegate methods
extension WeatherListViewController: WeatherListViewModelDelegate {
    func didFetchWeathers() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func didFailToFetchWeathersData(_ error: Error) {
        print("Weathers fetched")
    }
    
    
}

@available(iOS 17, *)
#Preview {
    WeatherListViewController(
        viewModel: WeatherListViewModel(
            weatherLoader: RemoteWithLocalFallbackWeatherLoader(localLoader: LocalWeatherLoader(store: CoreDataWeatherStore(), currentDate: Date.init),
                                                                remoteLoader: RemoteWeatherLoader(url: WeatherEndPoint.get.url, client: URLSessionHTTPClient(session: .shared)))
            
        )
        
    )
}
