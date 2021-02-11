//
//  List.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    //let clouds: Clouds
    //let wind: Wind
    let visibility: Int
    let pop: Double
    /*
    let rain: Rain?
    let sys: Sys*/
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather,  visibility, pop
             /*rain, sys,wind,clouds, */
        case dtTxt = "dt_txt"
    }
}
