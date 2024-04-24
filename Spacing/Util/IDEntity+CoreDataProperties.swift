//
//  IDEntity+CoreDataProperties.swift
//  Spacing
//
//  Created by TaeOuk Hwang on 4/24/24.
//
//

import Foundation
import CoreData


extension IDEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IDEntity> {
        return NSFetchRequest<IDEntity>(entityName: "IDEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?

}

extension IDEntity : Identifiable {

}
