//
//  Paper+CoreDataProperties.swift
//  
//
//  Created by minato on 2020/06/24.
//
//

import Foundation
import CoreData


extension Paper {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Paper> {
        return NSFetchRequest<Paper>(entityName: "Paper")
    }

    @NSManaged public var finish: String
    @NSManaged public var id: UUID
    @NSManaged public var importDate: Date
    @NSManaged public var quantity: Int16
    @NSManaged public var type: String
    @NSManaged public var width: Int16
    @NSManaged public var numOfRoll: Int16

}
