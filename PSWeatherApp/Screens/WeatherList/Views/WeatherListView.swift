//
//  WeatherListView.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

final class WeatherListView: UIView {
    let tableView = UITableView()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    init() {
        super.init(frame: .zero)
        configureTableView()
        configureSearchController()
        backgroundColor = .customBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherListCell.self, forCellReuseIdentifier: WeatherListCell.identifier)
        tableView.backgroundColor = .customBackground
        tableView.separatorStyle = .none
        
        
        tableView.rowHeight = UITableView.automaticDimension
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Country or City"
    }
}
