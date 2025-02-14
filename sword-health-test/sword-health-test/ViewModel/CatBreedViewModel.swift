//
//  CatBreedViewModel.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import Foundation

final class CatBreedViewModel {
    
    private let apiManager: APIManager
    private let dbManager: DBManager
    
    private var catBreeds = [CatBreedResponse]()
    private var favourites = [Favourites]()
    
    var reloadCollectionView: (()->())?
    
    private var cellViewModels = [CatBreedCellViewModel]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    var numberOfCells: Int {
        return catBreeds.count
    }
    
    init() {
        apiManager = APIManager()
        dbManager = DBManager()
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
    
    func getCellViewModel(at indexPath: IndexPath) -> CatBreedCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func getDetailsViewModel(at indexPath: IndexPath) -> CatBreedDetailViewModel {
        return CatBreedDetailViewModel(info: catBreeds[indexPath.row])
    }
    
    func createCell(breeds: [CatBreedResponse]) {
        self.catBreeds += breeds
        var vms = [CatBreedCellViewModel]()
        
        for breed in breeds {
            
            guard let name = breed.name,
                  let urlString = breed.image?.url,
                  let url = URL(string: urlString)
            else { return }
            
            vms.append(CatBreedCellViewModel(nameText: name, imageURL: url, isFavourite: isFavourite(breed)))
        }
        
        cellViewModels += vms
    }
    
    private func cleanData() {
        catBreeds.removeAll()
        cellViewModels.removeAll()
    }
    
    func saveFavouriteBreed(indexPath: IndexPath) {
        guard let id = catBreeds[indexPath.row].id,
              let name = catBreeds[indexPath.row].name,
              let url = catBreeds[indexPath.row].image?.url
        else { return }
        
        dbManager.saveFavouriteBreed(id: id, name: name, url: url)
    }
    
    func fetchFavourites() {
        dbManager.getFavouritesFromDataBase { favourites in
            self.favourites = favourites
        }
    }
    
    private func isFavourite(_ breed: CatBreedResponse) -> Bool {
        var isFavourite = false
        
        favourites.forEach { favourite in
            if favourite.id == breed.id {
                isFavourite = true
            }
        }
        
        return isFavourite
    }
}
