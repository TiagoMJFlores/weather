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
    let visibility: Int
    let pop: Double
    let dtTxt: String
    
    var timeStr: String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }

    enum CodingKeys: String, CodingKey {
        case dt, main, weather,  visibility, pop
        case dtTxt = "dt_txt"
    }
}
