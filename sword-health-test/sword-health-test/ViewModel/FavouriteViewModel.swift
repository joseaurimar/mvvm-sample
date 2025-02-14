//
//  FavouriteViewModel.swift
//  sword-health-test
//
//  Created by MAC on 14/02/2025.
//

import Foundation

final class FavouriteViewModel {
    
    var reloadCollectionView: (()->())?

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
    
    func createCell(favourites: [Favourites]) {
        self.favourites += favourites
        var vms = [CatBreedCellViewModel]()
        
        for favourite in favourites {
            
            guard let url = URL(string: favourite.url) else { return }
    
            vms.append(CatBreedCellViewModel(nameText: favourite.name, imageURL: url))
        }
        
        cellViewModels += vms
    }
    
    func getFavouritesFromDataBase() {
        dbManager.getFavouritesFromDataBase { favourites in
            self.createCell(favourites: favourites)
        }
    }
}
