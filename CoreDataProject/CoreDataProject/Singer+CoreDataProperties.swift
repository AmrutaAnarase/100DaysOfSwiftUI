//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Amruta on 17/04/21.
//
//
    
import Foundation
import CoreData


extension Singer {
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

   

}

extension Singer : Identifiable {

}
 
