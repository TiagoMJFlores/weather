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
    
    private var weatherViewData: [WeatherDayData] = []
    

    
    init(networkProvider: NetworkProviderProtocol = NetworkSessionProvider(session: URLSession.makeUrlSession()) /*WeatherProviderStub()*/, endPoint: WeatherApiServiceProtocol = WeatherApiService.search(text: "Madrid")) {
        self.weatherEndPoint = endPoint
        self.networkProvider = networkProvider
    }
    
    
    func viewWasLoaded() {
        networkProvider.request(type: Welcome.self, service: weatherEndPoint) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            
            case .success(let data):
              
                self.weatherViewData = self.mapModelDataToViewData(from: data.weatherList)
                
                break
            case .failure(_):
                break
            }
            
            self.weatherViewData.sort(by: { $0.day.compare($1.day) == .orderedAscending })
            self.view?.reloadData()
        }
    }
    
    
    private func sortWeatherByDay(from weatherList: [WeatherList]) ->  [String: [WeatherList]]  {
        var weatherData: [String: [WeatherList]] =  [String: [WeatherList]]()
        for item in weatherList {
            let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
            let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
            let dayStr = "\(calendarDate.day ?? 0)"
            var elementsInDay = weatherData[dayStr]
            if elementsInDay == nil {
                elementsInDay = []
            }
            elementsInDay?.append(item)
            weatherData[dayStr] = elementsInDay
        }
        return weatherData
    }
  
    private func mapModelDataToViewData(from weatherList: [WeatherList]) -> [WeatherDayData]  {
        let weatherData: [String: [WeatherList]] = sortWeatherByDay(from: weatherList)
        let weatherViewData: [WeatherDayData] = weatherData.keys.map { key in
            let elementsInDay = weatherData[key]
            let weatherViewData = WeatherDayData(day: key, weatherList: elementsInDay ?? [])
            
            return weatherViewData
        }
        return weatherViewData
    }
    
    
    func item(at indexPath: IndexPath) -> WeatherDayPresenterProtocol {
        
        let element = weatherViewData[indexPath.row]
        return WeatherDayPresenter(weatherData: element, imageDownloader: imageDownloader)
    }
    
    func numberItems() -> Int {
        return weatherViewData.count
    }
    
}
