//
//  IDEntity+CoreDataProperties.swift
//  
//
//  Created by TaeOuk Hwang on 4/25/24.
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
    @NSManaged public var profileImage: Date?

}
