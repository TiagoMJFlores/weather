//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

protocol WeatherListProtocol {
    
    func numberItems() -> Int
    func item(at indexPath: IndexPath) 
    
}

class WeatherListPresenter: WeatherListProtocol {
    
    weak var view: WeatherViewReceiver?
    
    func item(at indexPath: IndexPath) {
        
    }
    
    func numberItems() -> Int {
        return 5
    }
    
}
