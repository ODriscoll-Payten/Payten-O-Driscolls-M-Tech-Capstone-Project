//
//  ListViewModel.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/15/22.
//

import Foundation

/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 
 */

class ListViewModel: ObservableObject {
    @Published var listNavTitle = "Default List"
    
    @Published var todoLists: [Page] = [Page(name: "list 1", tasks: [ItemModel(title: "list 1 item 1", isCompleted: false)]), Page(name: "list 2", tasks: [ItemModel(title: "list 2 item 1", isCompleted: false)])]
    
    @Published var currentPage: Page
    
    @Published var items : [ItemModel] {
        didSet {
            saveItems()
        }
    }
    init() {
       let localCurrentPage = Page(name: "bruh", tasks: [])
        let localItems : [ItemModel] = localCurrentPage.tasks
        self.items = localItems
        self.currentPage = localCurrentPage
        getItems()
    }
    
    let itemsKey: String = "items_list"
    
    
    func getItems() {

        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        self.items = savedItems
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel){
        if let index = items.firstIndex(where: { $0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func setItems() {
        
        items = currentPage.tasks
        getItems()
    }
    
}
