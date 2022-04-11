//
//  ContentView.swift
//  WeSplit
//
//  Created by Amruta on 07/06/20.
//  Copyright © 2020 Amruta. All rights reserved.

////how many people are sharing the cost, and how much tip they want to leave,
import SwiftUI

struct ContentView: View {
    //there are three pieces of data we’re expecting users to enter into our app, that means we need to add three @State properties
    
    @State private var checkAmount = ""// must use strings to store text field values.
    @State private var numberOfPeople = ""
    @State private var selectedTipIndex = 2
    let tipPercentages = [10,15,20,25,0]//actually tipPercentages[2] = 20%
    //Add computed property totalPerPerson
    
    var tipAmount:Double{
        //tip amount calculation
       
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[selectedTipIndex])
        
        let tipValue = orderAmount / 100 * tipSelection
        return tipValue
    }
    var totalAmount:Double{
           //total amount
           let orderAmount = Double(checkAmount) ?? 0
           let grandValue = orderAmount + tipAmount
           return grandValue
       }
    var totalPerPerson:Double {
        //total amount for per person
        if let peopleCount = Double(numberOfPeople),
            peopleCount > 0 {
            return totalAmount/peopleCount
        }
        return 0
    }
   
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    TextField("Amount:", text: $checkAmount)//$checkAmountis two way binding, user types that property will be updated.
                        .keyboardType(.decimalPad)
                    
                    TextField("Number of people (min 2)", text: $numberOfPeople)
                        .keyboardType(.numberPad)
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            // Text(" \($0) people")
//                            Text("\($0) people")
//                        }
//                    }
                }
                
                Section(header: Text("How much tip you want to leave?"))
                {
                    Picker("Tip percentage", selection: $selectedTipIndex){
                        ForEach(0 ..< tipPercentages.count)
                        {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header:Text("Total amount for check")){
                   
                    Text("$\(totalAmount)")
                }.foregroundColor(tipPercentages[selectedTipIndex] == 0 ? .red : .blue)//we used conditional modifier( condn ? true stmt : false stmt)
                
                Section(header: Text("Amount per person")){
                    Text("$\(totalPerPerson)")
                }
                
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
