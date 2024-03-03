//
//  UIViewController+Alert.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 3.03.2024.
//

import UIKit

extension UIViewController {
    var loader: UIAlertController {
         let alert = UIAlertController(
             title: nil, message: "", preferredStyle: .alert
         )
         alert.view.translatesAutoresizingMaskIntoConstraints = false
         let indicator = UIActivityIndicatorView(style: .large)
         indicator.hidesWhenStopped = true
         indicator.translatesAutoresizingMaskIntoConstraints = false

         indicator.startAnimating()
         alert.view.addSubview(indicator)
         indicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
         indicator.centerYAnchor.constraint(equalTo: alert.view.centerYAnchor).isActive = true
         alert.view.widthAnchor.constraint(equalToConstant: indicator.bounds.width * 2).isActive = true
         alert.view.layer.cornerRadius = 10
         alert.view.heightAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
         return alert
     }

     func showLoader() {
         present(loader, animated: true)
     }

     func hideLoader(completion: (() -> Void)? = nil) {
         if let completion = completion {
             dismiss(animated: true) {
                 completion()
             }
         } else {
             dismiss(animated: true)
         }
     }

     func hideKeyboardWhenTappedAround() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
         tapGesture.cancelsTouchesInView = false
         view.addGestureRecognizer(tapGesture)
     }

     @objc func dismissKeyboard() {
         view.endEditing(true)
     }

     func showAlert(title: String?, message: String?, completion: (() -> Void)? = nil) {
         let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default) { _ in
             completion?()
         }
         alertController.addAction(okAction)
         present(alertController, animated: true, completion: nil)
     }
    
    func showAlertOnMainThread(title: String?, message: String?, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: title, message: message, completion: completion)
        }
    }
}


