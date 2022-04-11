//
//  AddView.swift
//  iExpense
//
//  Created by Amruta on 16/09/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    @State private var showingError = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                    .keyboardType(.alphabet)
                    
                Picker("Type", selection: $type){
                    ForEach(Self.types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save"){
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                }else{
                    //for validation of text field if wrong amount enterd
                    self.showingError = true
                    //it will directlyshow alert
                }
                //self.presentationMode.wrappedValue.dismiss()
            }
            .alert(isPresented: $showingError) {
                Alert(title: Text("Error"), message: Text("Please enter valid amount"), dismissButton: .default(Text("OK")))
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
