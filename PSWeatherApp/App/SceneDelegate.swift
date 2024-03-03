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
        
        window?.rootViewController = MainTabBarViewController(
            weatherListViewController: makeWeatherListViewController(),
            favouritesViewController: makeFavouritesViewController()
        )
        window?.makeKeyAndVisible()
    }

    
    private func makeWeatherListViewController() -> WeatherListViewController {
        let coreDataWeatherStore = CoreDataWeatherStore()
        let localWeatherLoder = LocalWeatherLoader(store: coreDataWeatherStore, currentDate: Date.init)
        let remoteWeatherLoader = RemoteWeatherLoader(url: WeatherEndPoint.get.url, client: URLSessionHTTPClient(session: .shared))
        
        let remoteWithLocalFallbackLoader = RemoteWithLocalFallbackWeatherLoader(localLoader: localWeatherLoder, remoteLoader: remoteWeatherLoader)
        
        let viewModel = WeatherListViewModel(weatherLoader: remoteWithLocalFallbackLoader)
        return WeatherListViewController(viewModel: viewModel)
    }
    
    private func makeFavouritesViewController() -> FavouritesViewController {
        FavouritesViewController()
    }
    
}

