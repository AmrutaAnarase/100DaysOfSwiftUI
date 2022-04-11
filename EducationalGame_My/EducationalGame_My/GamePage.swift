//
//  GamePage.swift
//  EducationalGame_My
//
//  Created by Amruta on 01/07/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI

struct Question {
    var text: String
    var answer: Int
}

struct GamePage: View {
    
    @State private var currentQuestion = Question(text: "2 * 2", answer: 4)
    @State private var questionsCount: Int = 0
    @State private var answer = ""
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var showingScore = false
    
    
    let uptoTable: Int
    let noOfQuestions: Int
    
    private var randomQuestion: Question {
        let number1 = Int.random(in: 1...uptoTable)
        let number2 = Int.random(in: 1...uptoTable)
        
        let questionText = "\(number1) * \(number2)"
        let ans = number1 * number2
        return Question(text: questionText, answer: ans)
    }
    
    var body: some View {
        ZStack{
//            LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .top, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
            Image("background")
            .renderingMode(.original)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("\(questionsCount)/\(noOfQuestions)")
                .fontWeight(.bold)
                    .background(Image("time"))
                 
                Spacer()
                Text("Your Question is  \n             \(currentQuestion.text)")
                    .fontWeight(.bold)
                Spacer()
                TextField("Your answer ", text: $answer)
                    .frame(width: 100, height: 40)
                    .multilineTextAlignment(.center)
                    .background(Image("input")
                        .renderingMode(.original)
                        .scaledToFit()
                        )
                
                Spacer()
                Button("Submit")
                {
                    let userAnswer = Int(self.answer) ?? 0
                    self.showingScore = true
                    self.questionsCount += 1
                    if userAnswer == self.currentQuestion.answer {
                        self.score += 10
                        self.scoreTitle = "Correct"
                    }else{
                        self.scoreTitle = "Sorry, Wrong answer!!!!"
                    }
                    if self.questionsCount == self.noOfQuestions{
                        self.scoreTitle = "All \(self.noOfQuestions) done.. Well Played.."
                        
                    }
                }
                .alert(isPresented: $showingScore){
                    Alert(title:Text(self.scoreTitle) ,message: Text("Your score is: \(self.score)"), dismissButton: .default(Text("Continue")){
                        self.askQuestion()
                        })
                }
                .font(.headline)
                .frame(width: 100, height: 5)
                .padding(20)
                .foregroundColor(Color.black)
                .background(Image("number")
                            .renderingMode(.original))
//                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.gray]), startPoint: .leading, endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                Text(" \(score)")
                    .fontWeight(.bold)
                    .background(Image("score"))
               
            }.frame(width: 300, height: 300, alignment: .center)
        }
    }
    
    func askQuestion(){
        print(questionsCount)
        answer = ""
        currentQuestion = randomQuestion
        
    }
}


struct GamePage_Previews: PreviewProvider {
    static var previews: some View {
        GamePage(uptoTable: 5, noOfQuestions: 10)
    }
}
