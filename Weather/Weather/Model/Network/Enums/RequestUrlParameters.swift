//
//  RequestUrlParameters.swift
//  Weather
//
//  Created by Tiago Flores on 12/02/2021.
//

import Foundation

typealias Parameters = [String: Any]

enum RequestUrlParameters {
    case none
    case requestParameters(Parameters)
}
