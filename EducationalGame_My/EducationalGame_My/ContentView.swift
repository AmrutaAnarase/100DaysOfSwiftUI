//
//  ContentView.swift
//  EducationalGame_My
//
//  Created by Amruta on 01/07/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var tables = 1
    @State private var questions = ["5","10","20","50"]
    @State private var questionIndex = 0
    
    private var noOfQuestions: Int {
        let questionsStr = questions[questionIndex]
        return Int(questionsStr) ?? -1
    }
  
    var body: some View {
        NavigationView{
            ZStack{
//                LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .top, endPoint: .bottomTrailing)
//                    .edgesIgnoringSafeArea(.all)
              
                Image("background")
                    .renderingMode(.original)
                    .edgesIgnoringSafeArea(.all)
                
                
                    VStack {
                        Text("Settings")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        Stepper("Practice for Tables from 1 to \(tables)", value: $tables, in: 1...12)
                        Spacer()
                        Picker(selection: $questionIndex, label: Text("Number of Questions"))
                        {
                            ForEach(0..<questions.count){
                                Text(self.questions[$0])
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                        Spacer()
                        Text("You want \(questions[questionIndex]) questions to ask...")
                            .fontWeight(.bold)
                            .background(Image("input").renderingMode(.original))
                            
                        Spacer()
                        NavigationLink(destination: GamePage(uptoTable: tables, noOfQuestions: noOfQuestions)) {
                            
                            Text("Start Game")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(minWidth: 0, maxWidth: 200)
                                .padding(20)
                                .foregroundColor(Color.black)
                                .background(Image("number")
                                .renderingMode(.original))
//                                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.gray]), startPoint: .leading, endPoint: .trailing))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                .frame(width: 350, height: 500, alignment: .center)
            }
            .navigationBarTitle("Educational Game")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
