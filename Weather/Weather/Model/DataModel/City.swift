//
//  City.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let country: String
    let population, timezone, sunrise, sunset: Int
}
