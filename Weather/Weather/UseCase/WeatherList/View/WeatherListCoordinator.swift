//
//  WeatherListCoordinator.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import UIKit


struct WeatherListCoordinator: CoordinatorProtocol {
        
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let presenter = WeatherListPresenter()
        let view = WeatherListViewController(presenter: presenter)
        presenter.view = view
        navigationController.pushViewController(view, animated: true)
    }
    

    
}
