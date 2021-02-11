//
//  NetworkProviderProtocol.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

protocol NetworkProviderProtocol {
    
    func request<T>(type: T.Type, completion: @escaping (NetworkAnswer<T>) -> ()) where T: Decodable
}
