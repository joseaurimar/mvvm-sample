//
//  MockAPIManager.swift
//  sword-health-test
//
//  Created by MAC on 15/02/2025.
//

class MockAPIManager: APIManagerProtocol {
    
    var shouldReturnError = false
    var mockData: [CatBreedResponse]?
    
    func fetchCatBreeds(pageSize: Int, completionHandler: @escaping (Result<[CatBreedResponse], HttpError>) -> Void) {
        if shouldReturnError {
            completionHandler(.failure(HttpError.badRequest))
        } else {
            completionHandler(.success(mockData!))
        }
    }
    
    func searchCatBreed(by key: String, pageSize: Int, completionHandler: @escaping (Result<[CatBreedResponse], HttpError>) -> Void) {
        if shouldReturnError {
            completionHandler(.failure(HttpError.serverError))
        } else {
            completionHandler(.success(mockData!))
        }
    }
}
