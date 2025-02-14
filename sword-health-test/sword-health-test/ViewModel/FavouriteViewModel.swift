//
//  FavouriteViewModel.swift
//  sword-health-test
//
//  Created by MAC on 14/02/2025.
//

import Foundation
import CoreData

final class FavouriteViewModel {
    
    var reloadCollectionView: (()->())?
    var container: NSPersistentContainer?
    var favourites = [Favourites]()
    
    var numberOfCells: Int {
        return favourites.count
    }
    
    private var cellViewModels = [CatBreedCellViewModel]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    init() {
        setupDataBase()
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
}

extension FavouriteViewModel {
    private func setupDataBase() {
        container = NSPersistentContainer(name: "CatBreedDB")
        
        container?.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    private func saveContext() {
        if let hasChanges = container?.viewContext.hasChanges, hasChanges {
            do {
                try container?.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    func getFavouritesFromDataBase() {
        var favourites = [Favourites]()
        
        let request = Favourites.createFetchRequest()
//        let sort = NSSortDescriptor(key: "date", ascending: false)
//        request.sortDescriptors = [sort]
        
        do {
            favourites = try container!.viewContext.fetch(request)
            createCell(favourites: favourites)
        } catch {
            print("Fetch failed")
        }
    }
}
