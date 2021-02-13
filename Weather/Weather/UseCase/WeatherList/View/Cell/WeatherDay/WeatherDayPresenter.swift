//
//  WeatherDayPresenter.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import UIKit

protocol WeatherDayPresenterProtocol: WeatherCollectionDataSource {
    var weatherData: WeatherDayData { get}
    func downloadImage(indexPath: IndexPath, completion: @escaping (UIImage) -> Void)
}

final class WeatherDayPresenter: WeatherDayPresenterProtocol {
    
    private(set) var imageDownloader: ImageDownloaderProtocol
    private(set) var weatherData: WeatherDayData
    
    init(weatherData: WeatherDayData, imageDownloader: ImageDownloaderProtocol) {
        self.weatherData = weatherData
        self.imageDownloader = imageDownloader
    }
    
}

extension WeatherDayPresenter: WeatherCollectionDataSource  {
    
    func weatherDataStr(indexPath: IndexPath) -> String {
        let element = item(at: indexPath)
        let result =  "Temperature: \(element.main.temp), Time: \(element.timeStr)"
        return result
    }
    
    private func imageUrl(for indexPath: IndexPath) -> String? {
        let element = item(at: indexPath)
        guard let weatherItem = element.weather.first else {
            return nil
        }
        let imageUrl =  "https://openweathermap.org/img/wn/\(weatherItem.icon)@2x.png"
        return imageUrl
    }
    
   
    func numberItems() -> Int {
        return weatherData.weatherList.count
    }
    
    func item(at indexPath: IndexPath) -> WeatherList {
        let element = weatherData.weatherList[indexPath.row]
        return element
    }
    
    
    func downloadImage(indexPath: IndexPath, completion: @escaping (UIImage) -> Void) {
        if let imageUrl = imageUrl(for: indexPath) {
            imageDownloader.downloadImage(imageUrl: imageUrl, completion: completion)
        }
    }
    
    
}
