//
//  ContentView.swift
//  Title:BetterRest--> it’s designed to help coffee drinkers get a good night’s sleep by asking them three questions:1.When do they want to wake up?,2.Roughly how many hours of sleep do they want?3.How many cups of coffee do they drink per day?Once we have those three values, we’ll feed them into Core ML to get a result telling us when they ought to go to bed.
//
//  Created by Amruta on 23/06/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
   static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
   
    
    var body: some View {
        NavigationView{
            Form{
                //this is challenge use Section insted of VStack
                Section{
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter your time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section{
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                        Text("\(sleepAmount, specifier: "%g") Hours")
                    }
                    
                }
                Section{
                   //this is challenge use picker instead of Stepper
                     Picker("Daily coffee intake", selection: $coffeeAmount){
                        ForEach(1 ..< 21){

                            Text("\($0) cups")
                        }
                    }.pickerStyle(WheelPickerStyle())
                    
//                    Text("Daily coffee intake")
//                        .font(.headline)
//                    Stepper(value: $coffeeAmount, in: 1...20){
//                        if(coffeeAmount == 1){
//                            Text("1 cup")
//                        }else{
//                            Text("\(coffeeAmount) cups")
//                        }
//                    }
                }
                
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                Button(action: calculateBedTime){
                    Text("Calculate")
                }
            )
        }
    }
    func calculateBedTime(){
        let model = SleepCalculator()
        //below code uses 0 if either the hour or minute can’t be read, but realistically that’s never going to happen so it will result in hour and minute being set to those values in seconds.
        
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            //prediction now contains how much sleep they actually need.
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep//ou can subtract a value in seconds directly from a Date, and you’ll get back a new Date
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is…"
            
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            // something went wrong!
        }
        showingAlert = true
        
    }
     
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
