//
//  Check__CapstoneApp.swift
//  Check- Capstone
//
//  Created by Payten O'Driscoll on 9/7/22.
//

import SwiftUI

@main
struct Check__CapstoneApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
