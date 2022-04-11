//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Amruta on 09/06/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

//Challenge ==Go back to the Guess the Flag project and add some animation:
//
//When you tap the correct flag, make it spin around 360 degrees on the Y axis.
//answer is here //https://github.com/Mattenhour/HackingSwiftUI/blob/master/Project6%20Wrap%20up/Project2/ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany","Ireland", "Italy","Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    //This is for accessibility
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    @State private var correctAnswer:Int = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var showingScore = false
    @State private var animationAmount = 0.0
    @State private var counter = false
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                Text("Tap the Flag...")
                    .font(.title)
                    .foregroundColor(.white)
                Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                VStack{
                    ForEach(0 ..< 3){ number in
                        Button(action: {
                            self.flagTapped(number)
                            
                        }) {
                            
                                FlagImage(imageName: self.countries[number])
                        }
                    
                        .alert(isPresented: $showingScore) {
                            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                                askQuestion()
                            })
                        }
                    }
                }
                Text("Your current score is  \(score)")
                    .foregroundColor(Color.white)
                    .fontWeight(.black)
            }
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 10
        } else{
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion(){
        
        countries.shuffle()///automatically takes care of randomizing the array order for us.
        correctAnswer = Int.random(in: 0...2)
        counter = false
    }
}


//View compotion - so we can split up one large view into multiple smaller views, and SwiftUI takes care of reassembling them for us.
struct FlagImage: View {
    var imageName : String
    var body: some View{
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 2))
            .shadow(color:.black , radius: 2)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
