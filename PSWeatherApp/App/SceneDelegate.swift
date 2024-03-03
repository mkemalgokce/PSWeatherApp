//
//  SceneDelegate.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        window?.rootViewController = MainTabBarViewController(
            weatherListViewController: makeWeatherListViewController(),
            favouritesViewController: makeFavouritesViewController()
        )
        createFavouriteWeatherStore()
        
        window?.makeKeyAndVisible()
    }

    private lazy var context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "WeatherDataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        
        return container.viewContext
    }()
    
    private lazy var remoteWeatherLoader: RemoteWeatherLoader = {
        let remoteWeatherLoader = RemoteWeatherLoader(url: WeatherEndPoint.get.url, client: URLSessionHTTPClient(session: .shared))
        return remoteWeatherLoader
    }()
    
    private lazy var localWeatherLoader: LocalWeatherLoader = {
        let coreDataWeatherStore = CoreDataWeatherStore(context: context)
        let localWeatherLoder = LocalWeatherLoader(store: coreDataWeatherStore, currentDate: Date.init)
            return localWeatherLoder
    }()
    
    
    private func makeWeatherListViewController() -> WeatherListViewController {
        let remoteWithLocalFallbackLoader = RemoteWithLocalFallbackWeatherLoader(localLoader: localWeatherLoader, remoteLoader: remoteWeatherLoader)
        let viewModel = WeatherListViewModel(weatherLoader: remoteWithLocalFallbackLoader)
        return WeatherListViewController(viewModel: viewModel)
    }
    
    private func makeFavouritesViewController() -> FavouritesViewController {
        let favouritesViewModel = FavouritesViewModel(favouriteManager: FavouriteWeatherManager.shared)
        return FavouritesViewController(viewModel: favouritesViewModel)
    }
    
    private func createFavouriteWeatherStore() {
        let store = FavouriteWeatherStore(context: context)
        FavouriteWeatherManager.shared.addStore(store)
    }
}

