//
//  ContentView.swift
//  iExpense
//
//  Created by Amruta on 07/07/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    //tracking state of AddView
    @State private var showingAddExpense = false
    
    // method capable of deleting an IndexSet of list items, then passing that directly on to our expenses array
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView{//ForEach will identify each expense item uniquely by its name,then prints name out as the list row.
            List{
                ForEach(expenses.items){ item in
                    HStack{
                        VStack(alignment: .leading)
                        {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        if (item.amount <= 10){
                            Text("Rs.\(item.amount)")
                                .foregroundColor(.red)
                        }else if (item.amount <= 100){
                            Text("Rs.\(item.amount)")
                                .foregroundColor(.yellow)
                        }else {
                            Text("Rs.\(item.amount)")
                                .foregroundColor(.green)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(),  trailing:
                Button(action: {
                    self.showingAddExpense = true
                })
                {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddExpense){
            AddView(expenses: self.expenses)
        }
    }
}

//want to store these items
// Identifiable means “this type can be identified uniquely.
struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
    
}
//to store an array of expense items inside a single object
class Expenses: ObservableObject {
    //save and load data in a clean way
    @Published var items = [ExpenseItem]() {
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    //to say that we mean we’re referring to the type itself, known as the type object – we write .self after it.
    init() {
        //which attempts to read whatever is in “Items” as a Data object
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            //Ask the decoder to convert the data we received from UserDefaults into an array of ExpenseItem objects.
            //which does the actual job of unarchiving the Data object into an array of ExpenseItem objects.
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
