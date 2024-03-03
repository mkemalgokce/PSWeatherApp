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
        viewModel.fetch()
    }
}
