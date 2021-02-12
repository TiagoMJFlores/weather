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



struct WeatherDayData {
    let day: String
    let weatherList: [WeatherList]
}

class WeatherListPresenter: WeatherListProtocol {
    
    weak var view: WeatherViewReceiver?
    private let imageDownloader = ImageDownloader()
    
    private let networkProvider: NetworkProviderProtocol
    private var weatherEndPoint: WeatherApiServiceProtocol
    
    private var weatherViewData: [WeatherDayData] = []
    
    private var weatherData: [String: [WeatherList]] =  [String: [WeatherList]]()
    
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
                for item in data.weatherList {
                    let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
                    let calendarDate = Calendar.current.dateComponents([.day, .year, .month], from: date)
                    
                    let dayStr = "\(calendarDate.day ?? 0)"
                    var elementsInDay = self.weatherData[dayStr]
                    if elementsInDay == nil {
                        elementsInDay = []
                    }
                    elementsInDay?.append(item)
                    self.weatherData[dayStr] = elementsInDay
                    let d = ""
                }
                let sd = ""
                break
            case .failure(_):
                break
            }
            
           
            self.weatherViewData = self.weatherData.keys.map { key in
                var elementsInDay = self.weatherData[key]
         
                let weatherViewData = WeatherDayData(day: key, weatherList: elementsInDay ?? [])
                
                return weatherViewData
            }
            
            self.weatherViewData.sort(by: { $0.day.compare($1.day) == .orderedAscending })
            /*
            for key in self.weatherData.keys {
                var elementsInDay = self.weatherData["\(calendarDate.day)"]
                print(key)
            }*/
          
            self.view?.reloadData()
            let sdd = ""
        }
    }
  
    func item(at indexPath: IndexPath) -> WeatherDayPresenterProtocol {
        
        let element = weatherViewData[indexPath.row]
        return WeatherDayPresenter(weatherData: element, imageDownloader: imageDownloader)
    }
    
    func numberItems() -> Int {
        return weatherViewData.count
    }
    
}
