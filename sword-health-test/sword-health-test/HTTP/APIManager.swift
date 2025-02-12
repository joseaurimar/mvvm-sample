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
    
    func fetchCatBreeds(pageSize: Int, completionHandler: @escaping (Result<[CatBreedResponse], HttpError>) -> Void) {
        
        let endpoint = "/breeds"
        let url = URL(string: baseURL + endpoint)!
        
        let queryPamaters = [
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "page", value: String(pageSize)),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        let request = buildRequest(url: url, with: nil, queryItems: queryPamaters)
        
        sendRequest(request: request) { result in
            
            switch result {
            case .success:
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let data = try? result.get() else { return }
                
                do {
                    let response = try jsonDecoder.decode([CatBreedResponse].self, from: data)
                    completionHandler(.success(response))
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func searchCatBreed(by key: String, pageSize: Int, completionHandler: @escaping (Result<[CatBreedResponse], HttpError>) -> Void) {
        
        let endpoint = "/breeds/search"
        let url = URL(string: baseURL + endpoint)!
        
        let queryPamaters = [
//            URLQueryItem(name: "limit", value: "10"),
//            URLQueryItem(name: "page", value: String(pageSize)),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "q", value: key)
        ]
        
        let request = buildRequest(url: url, with: nil, queryItems: queryPamaters)
        
        sendRequest(request: request) { result in
            
            switch result {
            case .success:
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                guard let data = try? result.get() else { return }
                
                do {
                    let response = try jsonDecoder.decode([CatBreedResponse].self, from: data)
                    completionHandler(.success(response))
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
