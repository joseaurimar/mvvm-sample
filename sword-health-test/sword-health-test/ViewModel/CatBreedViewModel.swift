//
//  CatBreedViewModel.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import Foundation

final class CatBreedViewModel {
    
    private let apiManager: APIManager
    
    var catBreeds = [CatBreedResponse]()
    var reloadCollectionView: (()->())?
    
    private var cellViewModels = [CatBreedCellViewModel]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    init() {
        self.apiManager = APIManager()
    }
    
    func getCatBreeds(pageSize: Int) {
        apiManager.fetchCatBreeds(pageSize: pageSize) { [weak self] result in
            do {
//                self?.totalProducts = try result.get().total ?? 0
                self?.createCell(breeds: try result.get())
            } catch {
                
            }
        }
    }
    
    func searchCatBreed(by key: String) {
        cleanData()
        apiManager.searchCatBreed(by: key, pageSize: 0) { [weak self] result in
            do {
                self?.createCell(breeds: try result.get())
            } catch {}
        }
    }
    
    var numberOfCells: Int {
        return catBreeds.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CatBreedCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(breeds: [CatBreedResponse]) {
        self.catBreeds += breeds
        var vms = [CatBreedCellViewModel]()
        
        for breed in breeds {
            
            guard let name = breed.name,
                  let urlString = breed.image?.url,
                  let url = URL(string: urlString)
            else { return }
            
            vms.append(CatBreedCellViewModel(nameText: name, imageURL: url))
        }
        
        cellViewModels += vms
    }
    
    private func cleanData() {
        catBreeds.removeAll()
        cellViewModels.removeAll()
    }
}
