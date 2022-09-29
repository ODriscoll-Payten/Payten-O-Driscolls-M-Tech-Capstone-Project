//
//  ListRowView.swift
//  Checkv2
//
//  Created by Payten O'Driscoll on 9/14/22.
//

import SwiftUI

struct ListRowView: View {
    
    let toDo: ToDo
    
    var body: some View {
        HStack{
            Image(systemName: toDo.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(toDo.isCompleted ? .green : .red)
            Text(toDo.unwrappedName )
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
    }
}

struct ListRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        
         let item1 = ToDo(context: viewContext)
        
         let item2 = ToDo(context: viewContext)
        
        
        Group{
            ListRowView(toDo: item1)
            ListRowView(toDo: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
