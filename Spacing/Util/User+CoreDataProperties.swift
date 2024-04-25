//
//  User+CoreDataProperties.swift
//  Spacing
//
//  Created by TaeOuk Hwang on 4/22/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var password: String?
    @NSManaged public var name: String?

}

extension User : Identifiable {

}
