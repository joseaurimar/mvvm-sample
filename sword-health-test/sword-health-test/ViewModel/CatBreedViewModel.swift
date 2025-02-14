//
//  CatBreedViewModel.swift
//  sword-health-test
//
//  Created by MAC on 11/02/2025.
//

import Foundation
import CoreData

final class CatBreedViewModel {
    
    private let apiManager: APIManager
    
    var catBreeds = [CatBreedResponse]()
    var reloadCollectionView: (()->())?
    var container: NSPersistentContainer?
    
    private var cellViewModels = [CatBreedCellViewModel]() {
        didSet {
            self.reloadCollectionView?()
        }
    }
    
    var numberOfCells: Int {
        return catBreeds.count
    }
    
    init() {
        self.apiManager = APIManager()
        setupDataBase()
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
            
            vms.append(CatBreedCellViewModel(nameText: name, imageURL: url))
        }
        
        cellViewModels += vms
    }
    
    private func cleanData() {
        catBreeds.removeAll()
        cellViewModels.removeAll()
    }
}

// MARK: Data Base Functions
extension CatBreedViewModel {
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
    
    func saveFavouriteBreed(indexPath: IndexPath) {
//        let favourites = Favourites(context: container!.viewContext)
        
        guard let name = catBreeds[indexPath.row].name,
              let url = catBreeds[indexPath.row].image?.url,
              let context = container?.viewContext
        else { return }
        
        let favourites = Favourites(context: context)
        configure(favourites: favourites, name: name, url: url)
        saveContext()
    }
    
    private func configure(favourites: Favourites, name: String, url: String) {
        favourites.name = name
        favourites.url = url
    }
    
    /*func getFavouritesFromDataBase() {
        var favourites = [Favourites]()
        
        let request = Favourites.createFetchRequest()
//        let sort = NSSortDescriptor(key: "date", ascending: false)
//        request.sortDescriptors = [sort]
        
        do {
            favourites = try container!.viewContext.fetch(request)
            print("Got \(favourites[0].name)")
            //                tableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }*/
}
