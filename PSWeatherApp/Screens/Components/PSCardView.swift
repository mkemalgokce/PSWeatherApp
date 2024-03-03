//
//  PSCardView.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

final class PSCardView: UIView {
    private let innerView: UIView
    private let gradientLayer = CAGradientLayer()
    
    private let padding: CGFloat
    init(innerView: UIView, colors: [UIColor], padding: CGFloat = 20.0) {
        self.innerView = innerView
        self.padding = padding
        super.init(frame: .zero)
        setupView()
        setupLayout()
        setupGradientLayer(colors: colors)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(innerView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
  
            innerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            innerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leadingAnchor.constraint(equalTo: innerView.leadingAnchor, constant: -padding),
            trailingAnchor.constraint(equalTo: innerView.trailingAnchor, constant: padding),
            topAnchor.constraint(equalTo: innerView.topAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: innerView.bottomAnchor, constant: padding),
            
        ])
    }
    
    private func setupGradientLayer(colors: [UIColor]) {
        gradientLayer.cornerRadius = 25
        gradientLayer.colors = colors.map { $0.cgColor }
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        
    }
    
}


@available(iOS 17, *)
#Preview {
    let image = UIImageView(image: .cloudFill)
    image.translatesAutoresizingMaskIntoConstraints = false
    image.widthAnchor.constraint(equalToConstant: 200).isActive = true
    image.heightAnchor.constraint(equalToConstant: 200).isActive = true
    image.contentMode = .scaleAspectFit
    return PSCardView(innerView: image, colors: [.systemCyan, .blue])
}
