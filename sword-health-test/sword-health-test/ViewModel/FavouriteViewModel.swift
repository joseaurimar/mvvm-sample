//
//  FavouriteViewModel.swift
//  sword-health-test
//
//  Created by MAC on 14/02/2025.
//

import Foundation

final class FavouriteViewModel {
    
    var reloadCollectionView: (()->())?
    var deleteItemCollectionView: ((IndexPath)->())?

    private var favourites = [Favourites]()
    private let dbManager: DBManager
    
    var numberOfCells: Int {
        return favourites.count
    }
    
    private var cellViewModels = [CatBreedCellViewModel]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    init() {
        dbManager = DBManager()
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> CatBreedCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func getDetailsViewModel(at indexPath: IndexPath) -> CatBreedDetailViewModel {
        
        let catBreedResponse = favourites.map { CatBreedResponse(id: $0.id,
                                                                 name: $0.name,
                                                                 temperament: $0.temperament,
                                                                 origin: $0.origin,
                                                                 description: $0.description,
                                                                 image: Image(id: "",
                                                                              width: 0,
                                                                              height: 0,
                                                                              url: $0.url))}
        
        return CatBreedDetailViewModel(info: catBreedResponse[indexPath.row])
    }
    
    func createCell(favourites: [Favourites]) {
        self.favourites += favourites
        var vms = [CatBreedCellViewModel]()
        
        for favourite in favourites {
            
            guard let url = URL(string: favourite.url) else { return }
    
            vms.append(CatBreedCellViewModel(nameText: favourite.name, imageURL: url, isFavourite: true))
        }
        
        cellViewModels += vms
    }
    
    func getFavouritesFromDataBase() {
        dbManager.getFavouritesFromDataBase { favourites in
            self.createCell(favourites: favourites)
        }
    }
    
    func deleteFavouriteFromDataBase(indexPath: IndexPath) {
        dbManager.deleteFavourite(favourites[indexPath.row])
        favourites.remove(at: indexPath.row)
        deleteItemCollectionView?(indexPath)
    }
}
