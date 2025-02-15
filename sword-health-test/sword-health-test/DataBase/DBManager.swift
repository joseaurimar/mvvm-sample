//
//  DBManager.swift
//  sword-health-test
//
//  Created by MAC on 14/02/2025.
//

import CoreData

final class DBManager {
    var container: NSPersistentContainer?
    
    init() {
        setupDataBase()
    }
    
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
    
    func saveFavouriteBreed(id: String, name: String, url: String) {
//        let favourites = Favourites(context: container!.viewContext)
        
        guard let context = container?.viewContext else { return }
        
        let favourites = Favourites(context: context)
        configure(favourites: favourites, id: id, name: name, url: url)
        saveContext()
    }
    
    private func configure(favourites: Favourites, id: String, name: String, url: String) {
        favourites.id = id
        favourites.name = name
        favourites.url = url
    }
    
    func getFavouritesFromDataBase(completionHandler: @escaping ([Favourites]) -> Void) {
//        var favourites = [Favourites]()
        
        let request = Favourites.createFetchRequest()
//        let sort = NSSortDescriptor(key: "date", ascending: false)
//        request.sortDescriptors = [sort]
        
        do {
            let favourites = try container!.viewContext.fetch(request)
            completionHandler(favourites)
        } catch {
            print("Fetch failed")
        }
    }
    
    func deleteFavourite(_ favourite: Favourites) {
        container?.viewContext.delete(favourite)
        saveContext()
    }
}
