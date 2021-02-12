//
//  URLSessionProtocol.swift
//  Weather
//
//  Created by Tiago Flores on 12/02/2021.
//

import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
    static func makeUrlSession() -> URLSessionProtocol
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession {
    
    static func makeUrlSession() -> URLSessionProtocol {
        let session = URLSession(
            configuration: URLSessionConfiguration.ephemeral, delegate: nil,
            delegateQueue: nil)
        return session
    }
}

extension URLSession: URLSessionProtocol {
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
    

}
