//
//  APIManager.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import Foundation

final class APIManager {
    
    private let session: URLSession
    private let baseURL = "https://api.thecatapi.com/v1"
    private let apiKey = "live_Ub0e8O2IXF92IGoVGS7oiG58qGrQqsbtS8rJsf6MB3nxBAzasLuAw2zv4wkFyFJu"
    
    init() {
        self.session = URLSession.shared
    }
    
    private func buildRequest(url: URL, with data: Data?, queryItems: [URLQueryItem]?) -> URLRequest {
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = queryItems
        
        var request = URLRequest(url: (urlComponents?.url)!)
        
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        request.httpMethod = "GET"
        request.httpBody = data
        
        return request
    }
    
    private func sendRequest(request: URLRequest, completionHandler: @escaping (Result<Data, HttpError>) -> Void) {
        
        self.session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Request error: \(error)")
            }
            
            guard let data = data else {
                print("data error")
                return
            }
            
            if let response = response {
                
                let httpResponse = response as! HTTPURLResponse
                
                if httpResponse.statusCode == 200 {
                    completionHandler(.success(data))
                } else if httpResponse.statusCode == 401 {
                    completionHandler(.failure(.unauthorized))
                }
            }
        }.resume()
    }
}
