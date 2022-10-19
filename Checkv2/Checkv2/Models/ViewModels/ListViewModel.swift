//
//  ListViewModel.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/15/22.
//

import Foundation
import SwiftUI

/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 
 */

class ListViewModel: ObservableObject {
    @Published var currentList: ToDoList?
    @Published var animate: Bool = false

    
    @Published var newToDoName: String = ""
    
    @Published var listNavTitle = "Default List"
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(
                        Animation
                            .easeInOut(duration: 2.0)
                            .repeatForever()
                        ) {
                            self.animate.toggle()
            }
        }
    }
    


    func updateToDo(toDo: ToDo){
        if let index = currentList?.toDosArray.firstIndex(where: { $0.id == toDo.id}) {
            currentList?.toDosArray[index].isCompleted = !toDo.isCompleted
        }
    }

}
