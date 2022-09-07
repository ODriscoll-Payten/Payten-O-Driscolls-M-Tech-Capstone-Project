//
//  AddToDoView.swift
//  Check- Capstone
//
//  Created by Payten O'Driscoll on 9/7/22.
//

import SwiftUI

struct AddToDoView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var importance: Double = 1
    var body: some View {
        Form{
            Section{
                TextField("ToDo Title", text: $title)
                
                VStack {
                    Text("Importance: \(Int(importance))")
                    Slider(value: $importance, in: 1...3, step: 1)
                }
                .padding()
                
                HStack{
                    Spacer()
                    Button("Submit") {
                        DataController().addToDo(title: title, importance: importance, context: managedObjContext)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
