//
//  UIView+AnimationUtils.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

extension UIView {
    func fadeIn(withDuration duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        self.alpha = 0
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }
    
    func fadeOut(withDuration duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: completion)
    }
    
    func move(to point: CGPoint, withDuration duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.center = point
        }, completion: completion)
    }
    
    func rotate(by angle: CGFloat, withDuration duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = self.transform.rotated(by: angle)
        }, completion: completion)
    }
    func scaleIn(withDuration duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        self.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        UIView.animate(withDuration: duration, animations: {
            self.transform = .identity
        }, completion: completion)
    }
    
    func scaleOut(withDuration duration: TimeInterval = 0.3, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }, completion: completion)
    }
    
    func scaleInOut(withDuration duration: TimeInterval = 0.3, scale: CGFloat = 0.5, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration/2, animations: {
            // Decrease scale
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }) { _ in
            UIView.animate(withDuration: duration/2, animations: {
                // Increase scale back to original size
                self.transform = .identity
            }, completion: completion)
        }
    }
}
