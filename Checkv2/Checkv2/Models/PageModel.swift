//
//  ListModel.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/15/22.
//

import Foundation

struct Page: Codable, Identifiable {
    var id = UUID()
    var name : String
    var tasks : [ItemModel] 
}


