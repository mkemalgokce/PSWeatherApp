//
//  FavouritesTableViewCell.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

final class FavouritesTableViewCell: UITableViewCell {
    static let identifier = "\(type(of: FavouritesTableViewCell.self))"
    
    private let headerLabel: PSHeaderLabel = {
        let label = PSHeaderLabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
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
    
    func configure(weather: Weather) {
        headerLabel.attributedText = NSMutableAttributedString(strings: [
            .init(string: "\(weather.country)\n", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .bold)]),
            .init(string: "\(weather.city)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .semibold)]),
        ])
        
        containerView.backgroundColor = randomColor()
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        addSubview(containerView)
        
        containerView.addSubview(headerLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            headerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            headerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 8),
            headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 0.5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if(selected) { fadeIn() }
    }
}
