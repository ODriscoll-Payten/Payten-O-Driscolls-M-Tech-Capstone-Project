//
//  EditToDoView.swift
//  Check- Capstone
//
//  Created by Payten O'Driscoll on 9/7/22.
//

import SwiftUI

struct EditToDoView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var toDo: FetchedResults<ToDo>.Element
    
    @State private var title = ""
    @State private var importance: Double = 1
    
    var body: some View {
        Form {
        Section {
            TextField("\(toDo.title!)", text: $title)
                .onAppear(){
                    title = toDo.title!
                    importance = toDo.importance
                }
            VStack{
                Text("Importance: \(Int(importance))")
                Slider(value: $importance, in: 1...3, step: 1)
            }
            .padding()
            
            HStack {
                Spacer()
                Button("Submit"){
                    DataController().editToDo(toDo: toDo, title: title, importance: importance, context: managedObjContext)
                    dismiss()
                }
            }
        }
    }
    }
}


