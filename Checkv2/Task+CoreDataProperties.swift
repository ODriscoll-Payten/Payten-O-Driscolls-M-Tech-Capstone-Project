//
//  Task+CoreDataProperties.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/21/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var date: Date?
    @NSManaged public var importance: Double
    @NSManaged public var origin: ToDoList?
    
    public var wrappedname: String {
        
        title ?? "Unknown task"
    }
    
    public var wrappedImportance: Double {
        importance ?? 0.0
    }

}

extension Task : Identifiable {

}
