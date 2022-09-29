//
//  ToDoList+CoreDataProperties.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/28/22.
//
//

import Foundation
import CoreData


extension ToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }

    @NSManaged public var name: String?
    @NSManaged public var toDos: NSSet?
    
    public var unwrappedName: String {
        name ?? "Unknown name"
    }
    
    public var toDosArray: [ToDo] {
        let toDoSet = toDos as? Set<ToDo> ?? []
        
        return toDoSet.sorted {
            $0.unwrappedName < $1.unwrappedName
        }
    }
    

}

// MARK: Generated accessors for toDos
extension ToDoList {

    @objc(addToDosObject:)
    @NSManaged public func addToToDos(_ value: ToDo)

    @objc(removeToDosObject:)
    @NSManaged public func removeFromToDos(_ value: ToDo)

    @objc(addToDos:)
    @NSManaged public func addToToDos(_ values: NSSet)

    @objc(removeToDos:)
    @NSManaged public func removeFromToDos(_ values: NSSet)

}

extension ToDoList : Identifiable {

}
