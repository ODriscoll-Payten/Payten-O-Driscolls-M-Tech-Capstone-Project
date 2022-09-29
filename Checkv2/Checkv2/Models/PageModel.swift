//
//  ListModel.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/15/22.
//

import Foundation

struct Page: Codable, Identifiable {
    var id : String
    var name : String
    var tasks : [ItemModel]
    
    init(id: String = UUID().uuidString, name: String, tasks: [ItemModel]) {
        self.id = id
        self.name = name
        self.tasks = tasks
    }
}


