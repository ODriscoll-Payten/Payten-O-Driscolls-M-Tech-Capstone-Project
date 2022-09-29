//
//  Persistence.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/21/22.
//
import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ToDoList")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved error: \(error)")
            }
        }
    }
}
