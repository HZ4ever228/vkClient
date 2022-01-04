//
//  Human+CoreDataProperties.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 30/12/2021.
//
//

import Foundation
import CoreData


extension Human {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Human> {
        return NSFetchRequest<Human>(entityName: "Human")
    }

    @NSManaged public var age: Int16
    @NSManaged public var sex: String?
    @NSManaged public var name: String?

}

extension Human : Identifiable {

}
