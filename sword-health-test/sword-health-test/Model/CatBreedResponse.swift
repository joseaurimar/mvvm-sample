//
//  CatBreedResponse.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import Foundation

struct CatBreedResponse: Codable, Equatable {
    let id: String?
    let name: String?
    let temperament: String?
    let origin: String?
    let description: String?
    let image: Image?
    
    static func == (lhs: CatBreedResponse, rhs: CatBreedResponse) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Image: Codable {
    let id: String?
    let width: Int?
    let height: Int?
    let url: String?
}
