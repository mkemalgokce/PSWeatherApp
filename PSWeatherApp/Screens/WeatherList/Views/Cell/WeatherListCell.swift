//
//  WeatherListCell.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

final class WeatherListCell: UITableViewCell {
    static let identifier = "\(type(of: WeatherListCell.self))"
    
    let weatherImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.image = UIImage(resource: .rainShowers)
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    let temperatureLabel: PSHeaderLabel = {
        let label = PSHeaderLabel()
        label.text = "36°"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 48, weight: .bold)

        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.text = "Turkey"
        label.textAlignment = .right
        label.textColor = .customTitle.withAlphaComponent(0.9)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "Istanbul"
        label.textAlignment = .right
        label.textColor = .customTitle.withAlphaComponent(0.9)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let windSpeedInfoView: PSWeatherInfoItemView = {
        let item = PSWeatherInfoItemView(title: "14.6", image: UIImage(systemName: "wind"))
        item.labelColor = .customTitle
        return item
    }()
    
    let humidityInfoView: PSWeatherInfoItemView = {
        let item = PSWeatherInfoItemView(title: "14.6", image: UIImage(systemName: "humidity"))
        item.labelColor = .customTitle
        return item
    }()
    
    let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.text = "sadas sadas sad"
        label.textColor = .customTitle
        label.textAlignment = .center
        return label
    }()
    
    private let infoVStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        
        return stack
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customBackground
        view.layer.cornerRadius = 25.0
        
        view.backgroundColor = .white.withAlphaComponent(0.2)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .customBackground
        addSubview(containerView)
        
        containerView.addSubview(weatherImageView)
        containerView.addSubview(infoVStack)
        containerView.addSubview(countryLabel)
        containerView.addSubview(cityLabel)
        containerView.addSubview(temperatureLabel)
        containerView.addSubview(weatherDescriptionLabel)
        
        
        infoVStack.addArrangedSubview(humidityInfoView)
        infoVStack.addArrangedSubview(windSpeedInfoView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            weatherImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            weatherImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: containerView.leadingAnchor, multiplier: 1),
            weatherImageView.widthAnchor.constraint(equalToConstant: 100),
            weatherImageView.heightAnchor.constraint(equalTo: weatherImageView.widthAnchor),
            
            temperatureLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: weatherImageView.trailingAnchor, multiplier: 2),
            temperatureLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            countryLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            countryLabel.leadingAnchor.constraint(greaterThanOrEqualTo: temperatureLabel.trailingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: infoVStack.trailingAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: countryLabel.leadingAnchor, constant: 8),
            cityLabel.trailingAnchor.constraint(equalTo: countryLabel.trailingAnchor),
            
            
            infoVStack.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            infoVStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: infoVStack.bottomAnchor, constant: 8),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: infoVStack.trailingAnchor),
            weatherDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            bottomAnchor.constraint(equalToSystemSpacingBelow: weatherImageView.bottomAnchor, multiplier: 2),
            
        ])
    }
    
    func configure(with weather: Weather) {
        temperatureLabel.text = "\(weather.temperature)"
        countryLabel.text = weather.country
        cityLabel.text = weather.city
        humidityInfoView.text = String(weather.humidity)
        windSpeedInfoView.text = String(weather.windSpeed)
        
        weatherDescriptionLabel.text = weather.weatherDescription.rawValue.capitalizedFirstLetterOfEachWord()
        weatherImageView.image = weather.weatherDescription.image()
        containerView.backgroundColor = weather.weatherDescription.color()
        
        //TODO: Move color logic to different class
        changeLabelColor(weather.weatherDescription.textColor())
        changeTintColor(weather.weatherDescription.tintColor())
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected { fadeIn() }
    }
    
    func changeLabelColor(_ color: UIColor) {
        temperatureLabel.textColor = color
        weatherDescriptionLabel.textColor = color
        countryLabel.textColor = color
        cityLabel.textColor = color
        humidityInfoView.labelColor = color
        windSpeedInfoView.labelColor = color
    }
    
    func changeTintColor(_ color: UIColor) {
        humidityInfoView.tintColor = color
        windSpeedInfoView.tintColor = color
    }
}

@available (iOS 17, *)
#Preview {
    WeatherListCell()
}
