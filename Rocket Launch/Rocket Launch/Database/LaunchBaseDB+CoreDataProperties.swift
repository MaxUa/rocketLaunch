//
//  LaunchBaseDB+CoreDataProperties.swift
//  
//
//  Created by Maxym Sahaydak on 2/15/18.
//
//

import Foundation
import CoreData


extension LaunchBaseDB {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<LaunchBaseDB> {
        return NSFetchRequest<LaunchBaseDB>(entityName: "LaunchBaseDB")
    }

    @NSManaged public var name: String?
    @NSManaged public var net: String?
    @NSManaged public var id: Int16

}
