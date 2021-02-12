//
//  WeatherPresenter.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

typealias WeatherListPresenterProtocol = WeatherListDelegate & WeatherListDataSource


final class WeatherListPresenter {
    
    weak var view: WeatherViewReceiver?
    private let imageDownloader = ImageDownloader()
    
    private var networkProvider: NetworkProviderProtocol
    private var defaultWeatherEndPoint: WeatherApiServiceProtocol
    private var weatherViewData: [WeatherDayData] = []
    
    init(networkProvider: NetworkProviderProtocol = NetworkSessionProvider(session: URLSession.makeUrlSession()) /*WeatherProviderStub()*/, endPoint: WeatherApiServiceProtocol = WeatherApiService.defaultAnswer) {
        self.defaultWeatherEndPoint = endPoint
        self.networkProvider = networkProvider
    }
    
}


extension WeatherListPresenter: WeatherListDelegate {
    
    func toggle(changeTo value: Bool) {
        if value == true {
            networkProvider = WeatherProviderStub()
        } else {
            networkProvider = NetworkSessionProvider(session: URLSession.makeUrlSession())
        }
        getData(using: defaultWeatherEndPoint)
    }
    

    func viewWasLoaded() {
        getData(using: defaultWeatherEndPoint)
    }
    
    private func getData(using weatherEndPoint: WeatherApiServiceProtocol) {
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
            let calendarDate = Calendar.current.dateComponents([.day , .month], from: date)
            let dayStr = "\(calendarDate.day ?? 0)/\(calendarDate.month ?? 0)"
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
    
    func search(searchText: String) {
        if searchText.isEmpty {
            getData(using: defaultWeatherEndPoint)
        } else {
            let searchEndPoint = WeatherApiService.search(text: searchText)
            getData(using: searchEndPoint)
        }
    }
    
}



extension WeatherListPresenter: WeatherListDataSource {
    
    func item(at indexPath: IndexPath) -> WeatherDayPresenterProtocol {
        
        let element = weatherViewData[indexPath.row]
        return WeatherDayPresenter(weatherData: element, imageDownloader: imageDownloader)
    }
    
    func numberItems() -> Int {
        return weatherViewData.count
    }
    
}
