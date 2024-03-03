//
//  PSHeaderLabel.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

final class PSHeaderLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        font = .systemFont(ofSize: 32, weight: .black)
        textColor = .customTitle
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.7
    }
}
