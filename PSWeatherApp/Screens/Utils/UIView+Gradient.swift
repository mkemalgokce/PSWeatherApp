//
//  UIView+Gradient.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

extension UIView {
    func gradientColor(bounds: CGRect, gradientLayer: CAGradientLayer) -> UIColor? {
            
            UIGraphicsBeginImageContext(gradientLayer.bounds.size)
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            gradientLayer.render(in: context)
            guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
                return nil
            }
            UIGraphicsEndImageContext()
            return UIColor(patternImage: image)
        }
}
