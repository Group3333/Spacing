//
//  ID+CoreDataProperties.swift
//  Spacing
//
//  Created by TaeOuk Hwang on 4/24/24.
//
//

import Foundation
import CoreData


extension ID {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ID> {
        return NSFetchRequest<ID>(entityName: "ID")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension ID : Identifiable {

}
