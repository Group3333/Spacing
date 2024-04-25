//
//  User+CoreDataProperties.swift
//  Spacing
//
//  Created by TaeOuk Hwang on 4/24/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "ID")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension User : Identifiable {

}
