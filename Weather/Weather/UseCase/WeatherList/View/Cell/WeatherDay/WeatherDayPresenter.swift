//
//  WeatherDayPresenter.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

protocol WeatherDayPresenterProtocol: WeatherCollectionDataSource {
    var imageDownloader: ImageDownloaderProtocol { get}
    var weatherData: WeatherDayData { get}
}

class WeatherDayPresenter: WeatherDayPresenterProtocol {
    private(set) var imageDownloader: ImageDownloaderProtocol
    private(set) var weatherData: WeatherDayData
    
    init(weatherData: WeatherDayData, imageDownloader: ImageDownloaderProtocol) {
        self.weatherData = weatherData
        self.imageDownloader = imageDownloader
    }
    
}

extension WeatherDayPresenter: WeatherCollectionDataSource  {
   
    func numberItems() -> Int {
        return weatherData.weatherList.count
    }
    
    func item(at indexPath: IndexPath) -> WeatherList {
        let element = weatherData.weatherList[indexPath.row]
        return element
    }
    
}
