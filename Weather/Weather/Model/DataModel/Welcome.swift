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
    let list: [List]
    let city: City
}
