//
//  FavouritesViewController.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

final class FavouritesViewController: UIViewController {
    private let favouritesView =  FavouritesView()
    private let viewModel: FavouritesViewModel
    
    private var tableView: UITableView {
        favouritesView.tableView
    }
    
    init(viewModel: FavouritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = favouritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetch()
    }
}

// MARK: - FavouritesViewModelDelegate methods
extension FavouritesViewController: FavouritesViewModelDelegate {
    func didFetchWeathers() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func didFailToFetchWeathers(_ error: Error) {
        showAlertOnMainThread(title: "Error", message: error.localizedDescription)
    }
    
}

//MARK: - UITableViewDelegate&DataSource methods
extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.identifier) as? FavouritesTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.configure(weather: viewModel.weather(at: indexPath))
        cell.update()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
