//
//  WeatherDummyStub.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

class WeatherProviderStub: NetworkProviderProtocol {
    
    private func retrieveJsonData() -> Data {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "dummy", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    func request<T>(type: T.Type, completion: @escaping (NetworkAnswer<T>) -> ()) where T : Decodable {
        
        let data = retrieveJsonData()
        let models = try! JSONDecoder().decode(T.self, from: data)
        completion(.success(models))
    }
    
}
