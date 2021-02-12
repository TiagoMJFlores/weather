//
//  NetworkAnswer.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

enum NetworkAnswer<T> {
    case success(T)
    case failure(NetworkError)
}
