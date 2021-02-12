//
//  Welcome.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

struct Welcome: Codable {
    let cod: String
    let message, cnt: Int
    let weatherList: [WeatherList]
    let city: City
    
    enum CodingKeys: String, CodingKey {
        case cod, message, cnt, city , weatherList = "list"
    }
}
