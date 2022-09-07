//
//  DataController.swift
//  Check- Capstone
//
//  Created by Payten O'Driscoll on 9/7/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ToDo")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!! yay!")
        } catch {
            print("We could not save the data..")
        }
    }
    
    func addToDo(title: String, importance: Double, context: NSManagedObjectContext) {
        let toDo = ToDo(context: context)
        toDo.id = UUID()
        toDo.date = Date()
        toDo.title = title
        toDo.importance = importance
        
        save(context: context)
    }
    
    func editToDo(toDo: ToDo, title: String, importance: Double, context: NSManagedObjectContext) {
        toDo.date = Date()
        toDo.title = title
        toDo.importance = importance
        
        save(context: context)
    }
}
