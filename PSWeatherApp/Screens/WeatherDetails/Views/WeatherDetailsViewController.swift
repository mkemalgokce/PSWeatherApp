//
//  WeatherDetailsViewController.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

final class WeatherDetailsViewController: UIViewController {
    private let viewModel: WeatherDetailViewModel
    private let weatherDetailsView = WeatherDetailsView()
    
    private var cellSize: CGSize = .init(width: 0, height: 0)
    
    private var collectionView: UICollectionView {
        weatherDetailsView.collectionView
    }
    
    init(viewModel: WeatherDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = weatherDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        weatherDetailsView.configure(with: viewModel.weather)
        view.backgroundColor = .customBackground
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
        
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherDetailsForecastCollectionViewCell.self,
                                forCellWithReuseIdentifier: WeatherDetailsForecastCollectionViewCell.identifier)
        
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Details"
        navigationItem.largeTitleDisplayMode = .never
        
        let image = viewModel.isInFavourite ? UIImage(systemName: "star.slash")
        : UIImage(systemName: "star")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(favouriteButtonTapped))
        navigationItem.rightBarButtonItem = item
    }
    
    @objc private func favouriteButtonTapped() {
        viewModel.favourite()
    }
    
}

extension WeatherDetailsViewController: WeatherDetailViewModelDelegate {
    
    func didStartLoading() {
    }
    
    func didFinishLoading() {
        
    }
    
    func didFailToCheckFavourite(_ error: Error) {
        showAlertOnMainThread(title: "Error", message: error.localizedDescription)
    }
    
    func didCheckToFavourite() {
        DispatchQueue.main.async { [weak self] in
            self?.configureNavigationBar()
        }
    }
    
    func didAddToFavourite() {
        DispatchQueue.main.async { [weak self] in
            self?.configureNavigationBar()
        }
        
    }
    
    func didFailToAddFavourite(_ error: Error) {
        showAlertOnMainThread(title: "Error", message: error.localizedDescription)
    }
    
    func didRemoveToFavourite() {
        DispatchQueue.main.async { [weak self] in
            self?.configureNavigationBar()
            
        }
    }
    
    func didFailToRemoveFavourite(_ error: Error) {
        showAlertOnMainThread(title: "Error", message: error.localizedDescription)
    }
    
    
}
//MARK: - UICollectionViewDelegate & UICollectionViewDataSource methods
extension WeatherDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.foreCastCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDetailsForecastCollectionViewCell.identifier, for: indexPath) as? WeatherDetailsForecastCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModel.forecast(at: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width / 2) - 16
        let height = width * 1.2
        let collectionViewHeight = collectionView.bounds.height
        
        if height > collectionViewHeight {
            cellSize = CGSize(width: collectionViewHeight - 16, height: collectionViewHeight)
        }else {
            cellSize = CGSize(width: width, height: height)
        }
        
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = cellSize.width
        let cellsWidth = (cellWidth * 2) + 18
        let leftInset: CGFloat = collectionViewWidth - cellsWidth
        return .init(top: 0, left: leftInset, bottom: 0, right: 0)
    }
}

