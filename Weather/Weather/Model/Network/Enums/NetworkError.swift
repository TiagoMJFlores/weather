//
//  NetworkError.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

enum NetworkError {
    case parsing(String)
    case unknown
    case noJSONData
}
