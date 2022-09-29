//
//  ListView.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/14/22.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var listViewModel: ListViewModel
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ToDoList.name, ascending: true)], animation: .default)
    private var toDoLists: FetchedResults<ToDoList>
    
    
    
    
    
    @State var animate: Bool = false
    let secondaryAccentColor = Color("SecondaryAccentColor")
    
    var body: some View {
        
            ZStack {
                if listViewModel.currentList?.toDosArray.isEmpty == true {
                    NoItemsView()
                        .transition(AnyTransition.opacity
                            .animation(.easeIn))
                } else {
                    List{
                        ForEach(listViewModel.currentList?.toDosArray ?? []) { item in
                            ListRowView(toDo: item)
                                .onTapGesture {
                                    withAnimation(.linear) {
                                        
                                    }
                                }
                        }
                        .onDelete(perform: deleteToDo(at:))
                        
                    }
                    .listStyle(PlainListStyle())
                    
                    NavigationLink(
                        destination: AddListView(),
                        label: {
                            Text("New List")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(height: 60)
                                .frame(maxWidth: 60)
                            
                                .background(animate ? secondaryAccentColor: Color.accentColor)
                                .cornerRadius(90)
                            
                        })
                    .simultaneousGesture(TapGesture().onEnded {
                        
                    })
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu(content: {
                        ForEach(toDoLists) { list in
                            Button(action: {
                                listViewModel.listNavTitle = list.name ?? "Cannot find List name"
                                listViewModel.currentList = list
                                
//                                listViewModel.setItems()
                            },
                            label: {
                                Text(list.name ?? "Unknown name")
                            })
                        }
                    }, label: {Text(listViewModel.listNavTitle)})
                }
            }
            
            .navigationTitle(listViewModel.currentList?.name ?? "Nothing")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    NavigationLink("Add", destination: AddView())
                
                
            )
            .onAppear {
                listViewModel.currentList = toDoLists.first
            }
        
    }
    
    func startApp() {
        
    }
    
    
    
    func deleteToDo(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let toDo = listViewModel.currentList!.toDosArray[index]
                viewContext.delete(toDo)
                PersistenceController.shared.saveContext()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newToDoList = ToDoList(context: viewContext)
        newToDoList.name = "Homework"
        
        let toDo1 = ToDo(context: viewContext)
        toDo1.name = "Assignment 1"
        
        let toDo2 = ToDo(context: viewContext)
        toDo2.name = "Assignment 2"
        
        newToDoList.addToToDos(toDo1)
        newToDoList.addToToDos(toDo2)
        
        
        
        
            
        
        return ListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}


