//
//  NetworkProviderService.swift
//  Weather
//
//  Created by Tiago Flores on 11/02/2021.
//

import Foundation

class NetworkSessionProvider: NetworkProviderProtocol {
    
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func request<T>(type: T.Type, service: EndPointDataProtocol, completion: @escaping (NetworkAnswer<T>) -> ()) where T : Decodable {
        var urlComps = URLComponents(string: service.baseURL + (service.path ?? ""))!
        urlComps.queryItems = service.queryItems
        let request = URLRequest(url: urlComps.url!)
        let task = session.dataTask(request: request, completionHandler: { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                let httpResponse = response as? HTTPURLResponse
                self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
            }
            
        })
        task.resume()
    }
    
    
private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkAnswer<T>) -> ()) {
    guard error == nil else { return completion(.failure(.unknown)) }
    guard let response = response else { return completion(.failure(.noJSONData)) }
    
    switch response.statusCode {
    case 200...299:
        
        guard let data = data else {
            return  completion(.failure(.noJSONData))
        }
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            completion(.success(model))
        } catch  {
            let errorMessage = "\(error)"
            return completion(.failure(.parsing(errorMessage)))
        }
        
    default:
        completion(.failure(.unknown))
    }
    
    }
}
