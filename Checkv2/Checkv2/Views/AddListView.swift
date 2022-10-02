//
//  AddListView.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/21/22.
//

import SwiftUI

struct AddListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State private var textFieldText: String = ""
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ToDoList.name, ascending: true)], animation: .default)
    
    private var toDoLists: FetchedResults<ToDoList>
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("Type something here..", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                
                
                Button(action: {
                    guard !textFieldText.isEmpty else {return}
                    
                    addToDoList()
                    textFieldText = ""
                    listViewModel.addAnimation()
                }, label: {
                    Text("Create List".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
                
                List {
                    ForEach(toDoLists) { list in
                        NavigationLink(destination: UpdateToDoListView(toDoList: list)) {
                            Text(list.name ?? "")
                        }
                    }.onDelete(perform: deleteToDoList)
                }
                .toolbar { EditButton() }
                .listStyle(PlainListStyle())
                
            }
            .navigationTitle("To-Do Lists")
            .padding(16)
        }
    }
    
    private func deleteToDoList(offsets: IndexSet) {
        withAnimation {
            offsets.map { toDoLists[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.saveContext()
        }
    }
    
    func addToDoList() {
        withAnimation {
            let newToDoList = ToDoList(context: viewContext)
            newToDoList.name = textFieldText
            PersistenceController.shared.saveContext()
        }
    }
    
}
    
    struct AddListView_Previews: PreviewProvider {
        static var previews: some View {
            AddListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }

