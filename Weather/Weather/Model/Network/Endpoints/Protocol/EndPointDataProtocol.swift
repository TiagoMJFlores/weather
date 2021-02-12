//
//  EndPointDataProtocol.swift
//  Weather
//
//  Created by Tiago Flores on 12/02/2021.
//

import Foundation

typealias Headers = [String: String]

protocol EndPointDataProtocol {
    var baseURL: String { get }
    var path: String? { get }
    var queryItems: [URLQueryItem] { get}

}

