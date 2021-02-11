//
//  CoordinatorProtocol.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import UIKit

protocol CoordinatorProtocol {
    
    var navigationController: UINavigationController { get set }
    func start()
}
