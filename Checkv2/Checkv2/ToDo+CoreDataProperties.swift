//
//  ToDo+CoreDataProperties.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 10/2/22.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var name: String?
    @NSManaged public var list: ToDoList?

    
    public var unwrappedName: String {
        name ?? "unknown todo name"
    }
    
}

extension ToDo : Identifiable {

}
