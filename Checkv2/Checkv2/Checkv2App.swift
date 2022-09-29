//
//  Checkv2App.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/14/22.
//

import SwiftUI

/*
 MVVM Architecture
 
 Model - data point
 View - UI
 ViewModel - manges Models for View
 
 */
@main
struct Checkv2App: App {
    @Environment(\.scenePhase ) var scenephase
    
    @StateObject var listViewModel : ListViewModel = ListViewModel()
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel)
            .environment(\.managedObjectContext, persistenceController.viewContext)
        }.onChange(of: scenephase) { _ in
            persistenceController.saveContext()
        }
    }
}
