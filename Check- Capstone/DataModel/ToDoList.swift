//
//  ToDoList.swift
//  Check- Capstone
//
//  Created by Payten O'Driscoll on 9/14/22.
//

import Foundation
struct ToDoList {
    var title : String
    var items : [ToDoListItem]
}

struct ToDoListItem {
    var date : Date
    var id : UUID
    var importance : Double
    var title: String
}

