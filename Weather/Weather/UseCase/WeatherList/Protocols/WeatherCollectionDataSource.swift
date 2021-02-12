//
//  WeatherCollectionDataSource.swift
//  Weather
//
//  Created by Tiago Flores on 12/02/2021.
//

import Foundation

protocol WeatherCollectionDataSource {
    func numberItems() -> Int
    func item(at indexPath: IndexPath) -> WeatherList
}
