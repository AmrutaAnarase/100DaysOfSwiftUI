//
//  ContentView.swift
//  UnitConversion_My
//
//  Created by Amruta on 08/06/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI

    
//    func convert(value: Double, toOtherUnit otherUnit: Unit) -> Double {
//        let seconds = Measurement(value: value, unit: UnitDuration.seconds)
//        return seconds.converted(to: .minutes).value
//    }
//}

struct ContentView: View {
    @State private var input = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    
    let unitNames = ["seconds", "minutes", "hours"]
    let units: [UnitDuration] = [.seconds, .minutes, .hours]
    
    var conversion: Double {
        guard let inputValue = Double(input) else {
            return 0
        }
        let firstUnit = units[inputUnit]
        let secondUnit = units[outputUnit]
        let first = Measurement(value: inputValue, unit: firstUnit)
        return first.converted(to: secondUnit).value
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Please select Input Unit")){
                    Picker("Input Units", selection: $inputUnit){
                        ForEach(0 ..< unitNames.count){
                            Text("\(self.unitNames[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    TextField("Enter a Number", text: $input)
                        .keyboardType(.numberPad)
                    
                }
                Section(header: Text("Please select Output Unit")){
                    Picker("Output Units", selection: $outputUnit){
                        ForEach(0 ..< unitNames.count){
                            Text("\(self.unitNames[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header:Text("Conversion Result")){
                    Text("\(conversion)")
                }
            }.navigationBarTitle("UnitConversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
