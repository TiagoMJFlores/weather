//
//  WeatherListDelegate.swift
//  Weather
//
//  Created by Tiago Flores on 12/02/2021.
//

import Foundation

protocol WeatherListDelegate {
    func viewWasLoaded()
    func search(searchText: String)
    func toggle(changeTo value: Bool)
}
