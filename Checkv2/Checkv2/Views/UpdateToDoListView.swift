//
//  UpdateListView.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/28/22.
//

import SwiftUI

struct UpdateToDoListView: View {
    // this has to do with updating list view
    @StateObject var toDoList: ToDoList
    
    @State private var toDoListName: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Update ToDo-List name", text: $toDoListName)
                    .textFieldStyle(.roundedBorder)
                Button(action: updateToDoList) {
                    Label("", systemImage: "arrowshape.turn.up.left")
                }
            }.padding()
            Text(toDoList.name ?? "")
            Spacer()
        }
    }
    
    private func updateToDoList() {
        withAnimation {
            toDoList.name = toDoListName
            PersistenceController.shared.saveContext()
        }
    }
}

struct UpdateListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newToDoList = ToDoList(context: viewContext)
        newToDoList.name = "Default List"
        
       return UpdateToDoListView(toDoList: newToDoList)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
