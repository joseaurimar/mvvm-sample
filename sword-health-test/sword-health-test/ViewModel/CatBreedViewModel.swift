//
//  CatBreedViewModel.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import Foundation

final class CatBreedViewModel {
    
    private let apiManager: APIManager
    
    init() {
        self.apiManager = APIManager()
    }
    
    func getCatBreeds(pageSize: Int) {
        apiManager.fetchCatBreeds(pageSize: pageSize) { [weak self] result in
            do {
//                self?.totalProducts = try result.get().total ?? 0
//                self?.createCell(products: try result.get().products ?? [])
            } catch {
                
            }
        }
    }
}
