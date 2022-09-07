//
//  ContentView.swift
//  Check- Capstone
//
//  Created by Payten O'Driscoll on 9/7/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.importance, order: .reverse)]) var toDo: FetchedResults<ToDo>
    
    @State private var showingAddView = false
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
               
                List{
                    ForEach(toDo) { toDo in
                        NavigationLink(destination: EditToDoView(toDo: toDo)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6){
                                    Text(toDo.title!)
                                        .bold()
                                    
                                    
                                    Text("Importance Level").foregroundColor(.red) +
                                    Text(" \(Int(toDo.importance))").foregroundColor(.red)
                                }
                                Spacer()
                                Text(calcTimeSince(date: toDo.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                        
                    }
                    .onDelete(perform: deleteToDo)
                }
                .listStyle(.plain)
            }
            .navigationTitle("ToDo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        showingAddView.toggle()
                    } label: {
                        Label("Add ToDo", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddToDoView()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func deleteToDo(offsets: IndexSet) {
        withAnimation{
            offsets.map {toDo[$0]}.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
