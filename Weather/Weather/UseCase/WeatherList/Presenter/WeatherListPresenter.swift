//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

protocol WeatherListProtocol {
    
    func viewWasLoaded()
    func numberItems() -> Int
    func item(at indexPath: IndexPath)  -> WeatherDayPresenterProtocol
    
}

class WeatherListPresenter: WeatherListProtocol {
    
    weak var view: WeatherViewReceiver?
    private let imageDownloader = ImageDownloader()
    
    private let networkProvider: NetworkProviderProtocol
    private var weatherEndPoint: WeatherApiServiceProtocol
    
    init(networkProvider: NetworkProviderProtocol = NetworkSessionProvider(session: URLSession.makeUrlSession()) /*WeatherProviderStub()*/, endPoint: WeatherApiServiceProtocol = WeatherApiService.search(text: "Madrid")) {
        self.weatherEndPoint = endPoint
        self.networkProvider = networkProvider
    }
    
    
    func viewWasLoaded() {
        networkProvider.request(type: Welcome.self, service: weatherEndPoint) { [weak self] (result) in
            guard let self = self else {
                return
            }
            self.view?.reloadData()
            let sdd = ""
        }
    }
  
    func item(at indexPath: IndexPath) -> WeatherDayPresenterProtocol {
        return WeatherDayPresenter(imageDownloader: imageDownloader)
    }
    
    func numberItems() -> Int {
        return 5
    }
    
}
