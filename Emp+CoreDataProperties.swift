//
//  Emp+CoreDataProperties.swift
//  w10c2
//
//  Created by Hyunjeong Choi on 2023-11-15.
//
//

import Foundation
import CoreData


extension Emp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Emp> {
        return NSFetchRequest<Emp>(entityName: "Emp")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64
    @NSManaged public var phone: String?

}

extension Emp : Identifiable {

}
