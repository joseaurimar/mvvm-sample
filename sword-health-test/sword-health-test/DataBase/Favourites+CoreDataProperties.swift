//
//  Favourites+CoreDataProperties.swift
//  sword-health-test
//
//  Created by MAC on 13/02/2025.
//
//

import Foundation
import CoreData

extension Favourites {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Favourites> {
        return NSFetchRequest<Favourites>(entityName: "Favourites")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var url: String

}

extension Favourites: Identifiable {

}
