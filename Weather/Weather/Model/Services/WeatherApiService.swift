//
//  WeatherApiService.swift
//  Weather
//
//  Created by Tiago Flores on 12/02/2021.
//

import Foundation

protocol WeatherApiServiceProtocol: EndPointDataProtocol {
    var searchText: String? { get }
}

enum WeatherApiService: WeatherApiServiceProtocol {
    
    var searchText: String? {
        switch self {
            case let .search(text):
                return text
            default:
                return nil
        }
    }

    case search(text: String)
    case defaultAnswer
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5"
    }
    
    var path: String? {
        return "/forecast?"
    }
    
     var queryItems: [URLQueryItem] {
        switch self {

        case .defaultAnswer:
            let queryItems = [URLQueryItem(name: "q", value: "Lisbon"), URLQueryItem(name: "appid", value: "5b9b1ff07f3972c825ba43eb281a31c7")]
        return queryItems
    
        case .search(let text):
            let queryItems = [URLQueryItem(name: "q", value: text), URLQueryItem(name: "appid", value: "5b9b1ff07f3972c825ba43eb281a31c7")]
        return queryItems
        }
    }
    
}
