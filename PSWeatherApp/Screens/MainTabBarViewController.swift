//
//  MainTabBarViewController.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let weatherListViewController: UIViewController
    private let favouritesViewController: UIViewController
    
    init(weatherListViewController: UIViewController, favouritesViewController: UIViewController) {
        self.weatherListViewController = weatherListViewController
        self.favouritesViewController = favouritesViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBackground
        createControllers()
    }
    
    private func createControllers() {
        
        let weatherNavigationController = createTab(weatherListViewController, title: "Weathers", image: UIImage(systemName: "cloud.sun"))
        let favouritesNavigationController = createTab(favouritesViewController, title: "Favourites", image: UIImage(systemName: "star"))
        
        setViewControllers([weatherNavigationController, favouritesNavigationController], animated: true)
    }
    
    private func createTab(_ controller: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        controller.title = title.uppercased()
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
        
}

