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
        header.text = "..."
        header.textColor = .white
        header.font = .preferredFont(forTextStyle: .title1)
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
        item.labelFont = .systemFont(ofSize: 20, weight: .semibold)
        item.tintColor = .white
        return item
    }()
    
    private let humidityInfoView: PSWeatherInfoItemView = {
        let item = PSWeatherInfoItemView(title: "14.6", image: UIImage(systemName: "humidity"))
        item.labelColor = .white
        item.labelFont = .systemFont(ofSize: 20, weight: .semibold)
        item.tintColor = .white
        return item
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.text = "..."
        label.textColor = .customTitle
        label.textAlignment = .center
        return label
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
        dateLabel.text = forecast.date.toDate(withFormat: "yyyy-MM-dd")?.getMonthAndDayString()
        temperatureLabel.text = String(forecast.temperature)
        windSpeedInfoView.text = String(forecast.windSpeed)
        humidityInfoView.text = String(forecast.humidity)
        weatherDescriptionLabel.text = forecast.weatherDescription.rawValue.capitalizedFirstLetterOfEachWord()
        
        weatherImageView.image = forecast.weatherDescription.image()
        
    }
    
    private func setupView() {
        layer.cornerRadius = 20
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        backgroundColor = .rain
        
        
        addSubview(dateLabel)
        addSubview(weatherImageView)
        addSubview(temperatureLabel)
        addSubview(weatherDescriptionLabel)
        addSubview(windSpeedInfoView)
        addSubview(humidityInfoView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            
            dateLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            
            weatherImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            weatherImageView.topAnchor.constraint(equalToSystemSpacingBelow: dateLabel.bottomAnchor, multiplier: 1),
            weatherImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            temperatureLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: weatherImageView.trailingAnchor, multiplier: 1),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            weatherDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: temperatureLabel.bottomAnchor, multiplier: 1),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: temperatureLabel.centerXAnchor),
            
            windSpeedInfoView.topAnchor.constraint(equalToSystemSpacingBelow: weatherDescriptionLabel.bottomAnchor, multiplier: 2),
            windSpeedInfoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            humidityInfoView.topAnchor.constraint(equalTo: windSpeedInfoView.bottomAnchor),
            humidityInfoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        
            
        ])
    }
    
}

@available(iOS 17, *)
#Preview {
    WeatherDetailsForecastCollectionViewCell()
}
