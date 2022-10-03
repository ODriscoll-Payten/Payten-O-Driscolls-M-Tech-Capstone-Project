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
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \ToDoList.dateCreated, ascending: true)], animation: .default)
    private var toDoLists: FetchedResults<ToDoList>
    
    @StateObject private var timerVm = TimerViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private let width: Double = 250
    
    @State var numberOfTasksSelected: Int = -1
    
    @State private var isShowingNewListView = false
    @State private var showPopup: Bool = false
    
    @State var animate: Bool = false
    
    @State var completedSectionIsVisible = true
    
    @State var initialCompletedTasks: Int = 0
    
    @State var popupNumber = 0
    
    
    var incompleteSectionIsVisible = true
    let secondaryAccentColor = Color("SecondaryAccentColor")
    let breakLabelText = "Take a break for:"
    let workLabelText = "Next Break In:"
    var isGoalCompleted : Bool {
        if listViewModel.currentList?.completedArray?.count ?? 0 == initialCompletedTasks + numberOfTasksSelected {
            return true
        } else {
            return false
        }
    }
    
    
    
    var body: some View {
        
        NavigationView {
            
            
            ZStack {
                
                if listViewModel.currentList?.toDosArray.isEmpty == true {
                    NoItemsView()
                        .transition(AnyTransition.opacity
                            .animation(.easeIn))
                } else {
                    
                    
                    List{
                        
                        VStack {
                            
                            Text(timerVm.timerLabel)
                                .font(.system(size: 10, weight: .medium, design: .rounded))
                               
                            HStack {
                                Text("\(timerVm.time)")
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                                    .alert("Time to take a break!", isPresented: $timerVm.showingTakeBreakAlert) {
                                        Button("Continue", role: .cancel) { if !isGoalCompleted {
                                            timerVm.timerLabel = breakLabelText
                                            timerVm.start(minutes: timerVm.breakTime)
                                        } else {
                                            timerVm.reset()
                                            timerVm.showingCongratsAlert = true
                                        }
                                        }
                                    }
                                
                                    .alert("Time to start Working", isPresented: $timerVm.showingBackToWorkAlert) {
                                        Button("Continue", role: .cancel) {
                                            if !isGoalCompleted {
                                                timerVm.timerLabel = workLabelText
                                                timerVm.start(minutes: timerVm.workTime)
                                            } else {
                                                timerVm.reset()
                                                timerVm.showingCongratsAlert = true
                                            }
                                        }
                                    }
                                
                                    .alert("GREAT JOB!! You completed \(numberOfTasksSelected) items in your \(listViewModel.currentList?.unwrappedName ?? "") list", isPresented: $timerVm.showingCongratsAlert) {
                                        Button("Continue", role: .cancel) {
                                            timerVm.reset()
                                            numberOfTasksSelected = -1
                                            initialCompletedTasks = -100
                                            popupNumber = 0
                                        }
                                    }
                            }
                        } .listRowBackground(secondaryAccentColor.opacity(0.4))
                        
                        .padding()
                        .frame(width: 150)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(secondaryAccentColor, lineWidth: 4))
                        
                        
                        Section("To-Do") {
                            ForEach(listViewModel.currentList?.incompleteArray ?? []) { item in
                                ListRowView(toDo: item)
                                    .onTapGesture {
                                        withAnimation(.linear) {
                                            item.isCompleted.toggle()
                                            PersistenceController.shared.saveContext()
                                            listViewModel.currentList = listViewModel.currentList
                                            print(item.isCompleted)
                                        }
                                    }
                                    
                                    
                                    
                            }
                            
                            .onDelete(perform: deleteToDo(at:))
                            .listRowBackground(secondaryAccentColor.opacity(0.3))
                            
                            
                        }
                        
                        
                        
                        Section("Completed") {
                            ForEach(listViewModel.currentList?.completedArray ?? []) { item in
                                ListRowView(toDo: item)
                                    .onTapGesture {
                                        withAnimation(.linear) {
                                            item.isCompleted.toggle()
                                            PersistenceController.shared.saveContext()
                                            listViewModel.currentList = listViewModel.currentList
                                            
                                            print(item.isCompleted)
                                        }
                                    }
                                
                            }
                            
                            .onDelete(perform: deleteToDo(at:))
                            .listRowBackground(secondaryAccentColor.opacity(0.3))
                        }
                        
                        
                    }
                    .onAppear(perform: addAnimation)
                    .listStyle(.insetGrouped)
                    
                    
                    
                    VStack{
                        
                        Spacer()
                        HStack{
                            
                            Button(action: {
                                withAnimation {
                                    showPopup.toggle()
                                }
                            }, label: {
                                Text("Start Session")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .frame(height: 50)
                                    .frame(maxWidth: 100)
                                    .background(animate ? secondaryAccentColor: Color.accentColor)
                                    .cornerRadius(10)
                            })
                            .frame(alignment: .top)
                            .padding(.horizontal, animate ? 30 : 50)
                            .shadow(color: animate ? secondaryAccentColor.opacity(0.7) : Color.accentColor.opacity(0.7),
                                    radius: animate ? 30 : 10 ,
                                    x: 0,
                                    y: animate ? 50 : 30)
                            .scaleEffect(animate ? 1.1 : 1.0)
                            .offset(y: animate ? -7 : 0)
                        }
                        .padding(20)
                    }
                    
                        .simultaneousGesture(TapGesture().onEnded {
                            
                        })
                }
            }
            
            
            .onReceive(timer) { _ in
                timerVm.updateCountdown()
                if isGoalCompleted {
                    timerVm.showingCongratsAlert = true
                }
                
            }
            
        }
        .popupNavigationView(horizontalPadding: 40, show: $showPopup) {
            
            // popup content
            VStack{
                Text("How many Tasks would you like to complete")
                Spacer()
                HStack{
                    Spacer()
                    Stepper("I will complete \(popupNumber) To - Do's", value: $popupNumber, in: 0...(listViewModel.currentList?.incompleteArray!.count)!)
                }
                Spacer()
            }
            .navigationTitle("Select Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
            
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        withAnimation{
                            numberOfTasksSelected = popupNumber
                            initialCompletedTasks = listViewModel.currentList?.completedArray?.count ?? 0
                            showPopup.toggle()
                            timerVm.start(minutes: timerVm.workTime)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        withAnimation {
                            showPopup.toggle()
                        }
                    }
                }
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
                    
                    Button("Create New List") {
                        isShowingNewListView = true
                    }
                    
                }, label: {Text("To-Do Lists")})
                .background(
                    NavigationLink(destination: AddListView(), isActive: $isShowingNewListView) {
                        EmptyView()
                    }
                )
            }
        }
        
        .navigationTitle(listViewModel.currentList?.name ?? "Nothing")
        
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink("Add", destination: AddView())
               
            
            
        )
        .onAppear {
            
            
            listViewModel.currentList = listViewModel.currentList
            
            if toDoLists.isEmpty {
                let defaultList = ToDoList(context: viewContext)
                defaultList.name = "Welcome!"
                listViewModel.currentList = defaultList
            }
            
            if listViewModel.currentList == nil {
                listViewModel.currentList = toDoLists.first
            }
            
            if listViewModel.currentList?.completedArray?.count ?? 0 <= 0 {
                completedSectionIsVisible = false
            } else {
                completedSectionIsVisible = true
            }
        }
        
        
    }
    
    
    func startApp() {
        
    }
    
    func addAnimation() {
//        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
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


