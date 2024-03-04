//
//  WeatherDetailsView.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

final class WeatherDetailsView: UIView {
    private let humidityTitle: String = "Humidity"
    private let windSpeedTitle: String = "Wind Speed"
    
    private let countryAndCityLabel: PSHeaderLabel = {
        let label = PSHeaderLabel()
        label.font = .systemFont(ofSize: 48, weight: .semibold)
        label.text = "..."
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.image = UIImage(resource: .rainShowers)
        view.contentMode = .scaleAspectFit

        return view
    }()
    
    private let temperatureLabel: PSHeaderLabel = {
        let label = PSHeaderLabel()
        label.text = "36°"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 72, weight: .bold)
        return label
    }()
    
    private let windSpeedInfoView: PSWeatherInfoItemView = {
        let item = PSWeatherInfoItemView(title: "Wind Speed: 14.6", image: UIImage(systemName: "wind"))
        item.labelFont = .systemFont(ofSize: 34, weight: .heavy)
        item.labelColor = .customTitle
        item.tintColor = .customSecond
        return item
    }()
    
    private let humidityInfoView: PSWeatherInfoItemView = {
        let item = PSWeatherInfoItemView(title: "Humidity: 14.6", image: UIImage(systemName: "humidity"))
        item.labelFont = .systemFont(ofSize: 34, weight: .heavy)
        item.labelColor = .customTitle
        item.tintColor = .customSecond
        return item
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Heavy Rainy"
        label.textColor = .customTitle
        label.textAlignment = .center
        return label
    }()
    
    private let topHStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        return stack
    }()
        
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
 
        return collectionView
        
    }()
    
    override var backgroundColor: UIColor? {
        didSet {
            collectionView.backgroundColor = backgroundColor
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(countryAndCityLabel)
        addSubview(topHStack)
        

        topHStack.addArrangedSubview(weatherImageView)
        topHStack.addArrangedSubview(temperatureLabel)

        addSubview(weatherDescriptionLabel)
        addSubview(windSpeedInfoView)
        addSubview(humidityInfoView)
        
        addSubview(collectionView)

        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            weatherImageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1/2),
        
            countryAndCityLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            countryAndCityLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            countryAndCityLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            topHStack.topAnchor.constraint(equalTo: countryAndCityLabel.bottomAnchor),
            topHStack.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            topHStack.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -32),
            topHStack.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 1/5),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: topHStack.bottomAnchor, constant: 16),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 16),
            
            windSpeedInfoView.topAnchor.constraint(equalToSystemSpacingBelow: weatherDescriptionLabel.bottomAnchor, multiplier: 2),
            windSpeedInfoView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            humidityInfoView.topAnchor.constraint(equalToSystemSpacingBelow: windSpeedInfoView.bottomAnchor, multiplier: 2),
            humidityInfoView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            humidityInfoView.widthAnchor.constraint(equalTo: windSpeedInfoView.widthAnchor),
            
            collectionView.topAnchor.constraint(equalTo: humidityInfoView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -12),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func configure(with weather: Weather) {
        countryAndCityLabel.attributedText = NSMutableAttributedString(strings: [
            .init(string: "\(weather.country)\n", attributes: [.font: UIFont.systemFont(ofSize: 48, weight: .bold)]),
            .init(string: "\(weather.city)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .semibold)]),
        ])
        temperatureLabel.text = "\(weather.temperature)"
        
        humidityInfoView.text = "\(humidityTitle): \(weather.humidity)"
        windSpeedInfoView.text = "\(windSpeedTitle): \(weather.windSpeed)"
        
        weatherDescriptionLabel.text = weather.weatherDescription.rawValue.capitalizedFirstLetterOfEachWord()
        weatherImageView.image = weather.weatherDescription.image()
        
    }
}

