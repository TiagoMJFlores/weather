//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

protocol WeatherListProtocol {
    
    func numberItems() -> Int
    func item(at indexPath: IndexPath)  -> WeatherDayPresenterProtocol
    
}

class WeatherListPresenter: WeatherListProtocol {
    
    weak var view: WeatherViewReceiver?
    private let imageDownloader = ImageDownloader()
    
    func item(at indexPath: IndexPath) -> WeatherDayPresenterProtocol {
        return WeatherDayPresenter(imageDownloader: imageDownloader)
    }
    
    func numberItems() -> Int {
        return 5
    }
    
}
