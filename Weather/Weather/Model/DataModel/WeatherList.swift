//
//  List.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

struct WeatherList: Codable {
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
    
    var timeStr: String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }

    enum CodingKeys: String, CodingKey {
        case dt, main, weather,  visibility, pop
             /*rain, sys,wind,clouds, */
        case dtTxt = "dt_txt"
    }
}
