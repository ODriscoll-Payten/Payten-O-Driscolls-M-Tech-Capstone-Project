//
//  AddView.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/14/22.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) private var viewContext

    
//    @State var newToDoName: String = ""
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var alertTitle : String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here..", text: $listViewModel.newToDoName)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(.systemGray5))
                .cornerRadius(10)
                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
                
            }
            .padding(16)
        }
        .navigationTitle("Add an Item 🖊")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            
            addToDo()
            
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if listViewModel.newToDoName.count < 3 {
            alertTitle = "Your new ToDo item must be at least 3 characters long 😨"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
    
    private func addToDo() {
        withAnimation {
            let newToDo = ToDo(context: viewContext)
            newToDo.name = listViewModel.newToDoName
            
            listViewModel.currentList!.addToToDos(newToDo)
            PersistenceController.shared.saveContext()
        }
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
