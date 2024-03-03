//
//  WeatherDetailsForecastCollectionViewCell.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

final class WeatherDetailsForecastCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(type(of: WeatherDetailsForecastCollectionViewCell.self))"
    private let dateLabel: PSHeaderLabel = {
        let header = PSHeaderLabel()
        header.text = "asdas"
        header.textColor = .white
        header.textAlignment = .center
        return header
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
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        return label
    }()
    
    private let windSpeedInfoView: PSWeatherInfoItemView = {
        let item = PSWeatherInfoItemView(title: "14.6", image: UIImage(systemName: "wind"))
        item.labelColor = .white
        item.labelFont = .systemFont(ofSize: 14)
        item.tintColor = .white
        return item
    }()
    
    private let humidityInfoView: PSWeatherInfoItemView = {
        let item = PSWeatherInfoItemView(title: "14.6", image: UIImage(systemName: "humidity"))
        item.labelColor = .white
        item.labelFont = .systemFont(ofSize: 14)
        item.tintColor = .white
        return item
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.text = "aasd"
        label.textColor = .customTitle
        label.textAlignment = .center
        return label
    }()
    
    private let innerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue.withAlphaComponent(0.6)
        view.layer.cornerRadius = 25
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with forecast: Forecast) {
        temperatureLabel.text = String(forecast.temperature)
        windSpeedInfoView.text = String(forecast.windSpeed)
        humidityInfoView.text = String(forecast.humidity)
        
        
        weatherImageView.image = forecast.weatherDescription.image()
        
        innerView.backgroundColor = forecast.weatherDescription.color()
        
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .customBackground
        
        addSubview(innerView)
        
        innerView.addSubview(dateLabel)
        innerView.addSubview(weatherImageView)
        innerView.addSubview(temperatureLabel)
        innerView.addSubview(weatherDescriptionLabel)
        innerView.addSubview(windSpeedInfoView)
        innerView.addSubview(humidityInfoView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            innerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            innerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            innerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            innerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            innerView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 16),
            
            innerView.widthAnchor.constraint(equalTo: innerView.heightAnchor, multiplier: 4/5),
            
            dateLabel.topAnchor.constraint(equalToSystemSpacingBelow: innerView.topAnchor, multiplier: 2),
            dateLabel.leadingAnchor.constraint(equalTo: innerView.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: innerView.trailingAnchor, constant: -8),
            
            
            weatherImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: innerView.leadingAnchor, multiplier: 2),
            weatherImageView.topAnchor.constraint(equalToSystemSpacingBelow: dateLabel.bottomAnchor, multiplier: 2),
            
            
            weatherImageView.widthAnchor.constraint(equalToConstant: 80),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            temperatureLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: weatherImageView.trailingAnchor, multiplier: 1),
            
            weatherDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: temperatureLabel.bottomAnchor, multiplier: 1),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: temperatureLabel.centerXAnchor),
            
            windSpeedInfoView.topAnchor.constraint(equalToSystemSpacingBelow: weatherDescriptionLabel.bottomAnchor, multiplier: 1),
            windSpeedInfoView.centerXAnchor.constraint(equalTo: innerView.centerXAnchor),
            
            humidityInfoView.topAnchor.constraint(equalTo: windSpeedInfoView.bottomAnchor),
            humidityInfoView.centerXAnchor.constraint(equalTo: innerView.centerXAnchor),
            
            
            leadingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -16),
            trailingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: humidityInfoView.bottomAnchor, constant: 16),
            topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -16),
            
            
        ])
    }
    
}

@available(iOS 17, *)
#Preview {
    WeatherDetailsForecastCollectionViewCell()
}
