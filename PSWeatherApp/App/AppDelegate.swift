//
//  AppDelegate.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureUI()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    private func configureUI() {
        configureNavBar()
        configureTabBar()
    }
    
    private func configureNavBar() {
        UINavigationBar.appearance().barTintColor = .customBackground
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }

    private func configureTabBar() {
        UITabBar.appearance().backgroundColor = .customBackground
        UITabBar.appearance().barTintColor = .customBackground
        UITabBar.appearance().tintColor = .customTitle
        UITabBar.appearance().unselectedItemTintColor = .unselected.withAlphaComponent(0.4)
        UITabBar.appearance().isTranslucent = false
    }

}

