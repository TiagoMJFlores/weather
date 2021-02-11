//
//  WeatherDayPresenter.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

protocol WeatherDayPresenterProtocol {
    var imageDownloader: ImageDownloaderProtocol { get}
    
}

class WeatherDayPresenter: WeatherDayPresenterProtocol {
    var imageDownloader: ImageDownloaderProtocol
    
    init(imageDownloader: ImageDownloaderProtocol) {
        self.imageDownloader = imageDownloader
    }
    
}
