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
        title = viewModel.title
        weatherDetailsView.configure(with: viewModel.weather)
        navigationController?.navigationBar.prefersLargeTitles = true
        setupCollectionView()
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
        cell.backgroundColor = viewModel.weather.weatherDescription.color()
        cell.configure(with: viewModel.forecast(at: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 250)
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
