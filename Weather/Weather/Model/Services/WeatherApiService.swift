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
        let url = InfoPListStringReader.BASE_URL.getValue()
        return url ?? ""
    }
    
    var path: String? {
        return "/forecast?"
    }
    
     var queryItems: [URLQueryItem] {
        switch self {

        case .defaultAnswer:

            var queryItems = [URLQueryItem(name: "q", value: "Lisbon")]
            queryItems.append(contentsOf: defaultQueryItems)
        return queryItems
    
        case .search(let text):
            var queryItems = [URLQueryItem(name: "q", value: text)]
            queryItems.append(contentsOf: defaultQueryItems)
        return queryItems
        }
    }
    
    private var defaultQueryItems: [URLQueryItem] {
        let apiKey = InfoPListStringReader.API_KEY.getValue()
        let queryItems = [URLQueryItem(name: "appid", value: apiKey)]
        return queryItems
    }
    
}
