//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Amruta on 17/04/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
   

   @State private var lastNameFilter = "A"
    
    
    var body: some View {
        VStack {
            FilteredList(filter: lastNameFilter)
            
            Button("Add Examples") {
                let sonu = Singer(context: self.viewContext)
                sonu.firstName = "Sonu"
                sonu.lastName = "Sigam"
                
                let neha = Singer(context: self.viewContext)
                neha.firstName = "Neha"
                neha.lastName = "Kakkar"
                
                let aryya = Singer(context: self.viewContext)
                aryya.firstName = "Aryya"
                aryya.lastName = "Ambekar"
                
                try? self.viewContext.save()
                
                
            }
            
            Button("Show A"){
                self.lastNameFilter = "A"
            }
            
            Button("Show S"){
                self.lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
