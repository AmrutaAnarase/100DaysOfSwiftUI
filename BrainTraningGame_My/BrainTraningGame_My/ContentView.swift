//
//  ContentView.swift
//  BrainTraningGame_My
//
//  Created by Amruta on 18/06/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI
import Combine

class IndexManager: ObservableObject {
    @Published var index = -1 {
        didSet {
            if self.index >= 0 {
                publisher.send(index)
            }
        }
    }
    func reset() {
        self.index = -1
    }
    let publisher = PassthroughSubject<Int, Never>()
}

struct ContentView: View {
    private var firstItems = ["Rock", "Paper", "Scissors"]
    @State private var selectedItem = Int.random(in: 0..<3)
    private var secondItems = ["Win", "Loose"]
    @State private var winOrLoose = Int.random(in: 0..<2)
    @ObservedObject private var indexManager = IndexManager()
    @State private var score = 0
    @State private var showingAlert = false
    
    func resetTurn() {
        self.selectedItem = Int.random(in: 0..<3)
        self.winOrLoose = Int.random(in: 0..<2)
        self.indexManager.reset()
    }
    
    var isTurnPassed: Bool{
        let first = firstItems[selectedItem]
        let second = secondItems[winOrLoose]
            //first we check for Rock
        if(first == firstItems[0] && second == secondItems[0] && firstItems[indexManager.index] == firstItems[1]){
            
            return true
            
        } else if(first == firstItems[0] && second == secondItems[1] && firstItems[indexManager.index] == firstItems[2]){
            return true
        }
        
        //first we check for Paper
        if(first == firstItems[1] && second == secondItems[0] && firstItems[indexManager.index] == firstItems[2]){
            return true
            
        } else if(first == firstItems[1] && second == secondItems[1] && firstItems[indexManager.index] == firstItems[0]){
            return true
        }
        
        //first we check for Scissors
        if(first == firstItems[2] && second == secondItems[0] && firstItems[indexManager.index] == firstItems[1]){
            return true
            
        } else if(first == firstItems[2] && second == secondItems[1] && firstItems[indexManager.index] == firstItems[0]){
            return true
        }
        
        return false
    }
    
    var body: some View {
        
        NavigationView{
            
            Form {
                Section(header: Text("To")){
                    Text(self.secondItems[winOrLoose])
                }
                Section(header: Text("Over")){
                    Text(self.firstItems[selectedItem])
                }
                Section(header:Text("You should select")){
                    Picker(selection: $indexManager.index, label: Text("Please choose something...")){
                        ForEach(0..<3){
                            Text(self.firstItems[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .onReceive(indexManager.publisher) { int in
                        if self.isTurnPassed {
                            self.score += 50
                        }
                        self.showingAlert = true
                    }.alert(isPresented: self.$showingAlert) {
                        Alert(title: Text(self.isTurnPassed ? "Right choice" : "Wrong choice"), message: nil, dismissButton: .default(Text("Ok")){
                            if self.isTurnPassed {
                                self.resetTurn()
                            }
                        })
                    }
                }
                
                Section(header:Text("your score")) {
                    Text("\(self.score)")
                }
            }.navigationBarTitle("Brain Training Game")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
