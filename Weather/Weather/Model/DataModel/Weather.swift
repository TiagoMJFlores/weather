//
//  Weather.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: MainEnum
    //let weatherDescription: Description
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        //case weatherDescription = "description"
        case icon
    }
}
