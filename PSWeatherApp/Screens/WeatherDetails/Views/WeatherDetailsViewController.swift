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
        view.backgroundColor = .customBackground
        weatherDetailsView.configure(with: viewModel.weather)
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Details"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherDetailsForecastCollectionViewCell.self,
                                forCellWithReuseIdentifier: WeatherDetailsForecastCollectionViewCell.identifier)

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
        return CGSize(width: width, height: width * 1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    
    
}

@available(iOS 17, *)
#Preview {
    UINavigationController(rootViewController: WeatherDetailsViewController(
        viewModel: WeatherDetailViewModel(weather: Weather(id: 1,
                                                           city: "Istanbul",
                                                           country: "Turkey",
                                                           temperature: 21.2,
                                                           weatherDescription: .cloudy,
                                                           humidity: 12,
                                                           windSpeed: 23, forecast: [
                                                            Forecast(date: Date.now.description, temperature: 23, weatherDescription: .sunny, humidity: 12, windSpeed: 23),
                                                            Forecast(date: Date.now.description, temperature: 25, weatherDescription: .rain, humidity: 12, windSpeed: 23),
                                                            Forecast(date: Date.now.description, temperature: 23, weatherDescription: .sunny, humidity: 12, windSpeed: 23),
                                                           
                                                           ]))
    ))
}
