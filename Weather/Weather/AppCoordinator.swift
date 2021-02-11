//
//  AppCoordinator.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import UIKit
import Foundation

struct AppCoordinator {
 
    let window: UIWindow
    let navigationController = UINavigationController()
    
    init(window: UIWindow) {
        self.window = window
        window.rootViewController = navigationController
    }
    
    func start() {
        
        let listCoordinator = WeatherListCoordinator(navigationController: navigationController)
        listCoordinator.start()
        window.makeKeyAndVisible()
    }
    
}
