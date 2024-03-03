//
//  SceneDelegate.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = WeatherListViewController(
            viewModel: WeatherListViewModel(
                weatherLoader: RemoteWithLocalFallbackWeatherLoader(localLoader: LocalWeatherLoader(store: CoreDataWeatherStore(), currentDate: Date.init),
                                                                    remoteLoader: RemoteWeatherLoader(url: WeatherEndPoint.get.url, client: URLSessionHTTPClient(session: .shared)))
                
            )
            
        )
        window?.makeKeyAndVisible()
    }

}

