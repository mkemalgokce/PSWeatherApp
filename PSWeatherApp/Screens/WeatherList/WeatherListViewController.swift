//
//  WeatherListViewController.swift
//  PSWeatherApp
//
//  Created by Mustafa Kemal Gökçe on 2.03.2024.
//

import UIKit

final class WeatherListViewController: UIViewController {
    private let viewModel: WeatherListViewModel
    
    init(viewModel: WeatherListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        viewModel.fetch()
    }
    
}


// MARK: - WeatherListViewModelDelegate methods
extension WeatherListViewController: WeatherListViewModelDelegate {
    func didFetchWeathers() {
        
    }
    
    func didFailToFetchWeathersData(_ error: Error) {
        
    }
    
    
}

@available(iOS 17, *)
#Preview {
    WeatherListViewController(
        viewModel: WeatherListViewModel(
            weatherLoader: RemoteWithLocalFallbackWeatherLoader(localLoader: LocalWeatherLoader(store: CoreDataWeatherStore(), currentDate: Date.init),
                                                                remoteLoader: RemoteWeatherLoader(url: WeatherEndPoint.get.url, client: URLSessionHTTPClient(session: .shared)))
            
        )
        
    )
}
