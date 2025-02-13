//
//  CatBreedDetailViewModel.swift
//  sword-health-test
//
//  Created by MAC on 12/02/2025.
//

import Foundation

struct CatBreedDetailViewModel {
    
    let nameText: String
    let imageURL: URL
    let originText: String
    let temperamentText: String
    let descriptionText: String
    
    init(info: CatBreedResponse) {
        
        guard let name = info.name,
              let urlString = info.image?.url,
              let url = URL(string: urlString),
              let origin = info.origin,
              let temperament = info.temperament,
              let description = info.description
        else {
            nameText = ""
            imageURL = URL(string: "")!
            originText = ""
            temperamentText = ""
            descriptionText =  ""
            return
        }
        
        nameText = name
        imageURL = url
        originText = origin
        temperamentText = temperament
        descriptionText = description
    }
}
