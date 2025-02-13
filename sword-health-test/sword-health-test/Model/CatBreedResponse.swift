//
//  CatBreedResponse.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import Foundation

struct CatBreedResponse: Codable {
    let name: String?
    let temperament: String?
    let origin: String?
    let description: String?
    let image: Image?
}

struct Image: Codable {
    let id: String
    let width: Int
    let height: Int
    let url: String
}
