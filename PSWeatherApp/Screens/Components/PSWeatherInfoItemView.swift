//
//  PSWeatherInfoItemView.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

final class PSWeatherInfoItemView: UIView {
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .heavy)
        label.textAlignment = .right
        return label
    }()
    
    private let infoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 25.0
        return view
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    var labelColor: UIColor = .black {
        didSet {
            infoLabel.textColor = labelColor
        }
    }
    
    var labelFont: UIFont = .systemFont(ofSize: 12) {
        didSet {
            infoLabel.font = labelFont
        }
    }
    
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = title
        infoImageView.image = image?.withTintColor(tintColor, renderingMode: .alwaysTemplate)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stack)

        stack.addArrangedSubview(infoLabel)
        stack.addArrangedSubview(infoImageView)
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            infoImageView.widthAnchor.constraint(equalTo: infoImageView.heightAnchor),
            
            trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            
            topAnchor.constraint(equalTo: stack.topAnchor),
            bottomAnchor.constraint(equalTo: stack.bottomAnchor),
        ])
        
    }
}

@available(iOS 17, *)
#Preview {
    let view = PSWeatherInfoItemView(title: "Human", image: .actions)
    view.labelColor = .red
    view.tintColor = .green
    return view
}
