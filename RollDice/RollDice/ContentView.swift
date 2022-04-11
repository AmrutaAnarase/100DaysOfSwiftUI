//
//  ContentView.swift
//  RollDice
//
//  Created by Amruta on 20/01/22.
//

import SwiftUI

struct ContentView: View {
    let diceNames = ["Dice1", "Dice2","Dice3","Dice4","Dice5","Dice6"]
    @State var indexNo = 0
    @State var prevIndexNo = 0
    @State var totalOfIndex = 1
    @State private var feedback = UINotificationFeedbackGenerator()
    var body: some View {
        NavigationView {
            GeometryReader { fullView in
                VStack{
                    Spacer()
                    Image(diceNames[indexNo])
                        .frame(width: fullView.size.width * 0.4, height: fullView.size.width * 0.3)
                    
                    Text("\(indexNo + 1)")
                        .bold()
                        .font(.largeTitle)
                        .padding()
                        .frame(width: fullView.size.width * 0.3, height: fullView.size.width * 0.2)
                        .background(.red)
                        .cornerRadius(30)
                    //Spacer()
                    
                    Text("Total  \n\(prevIndexNo) + \(indexNo + 1) = \(totalOfIndex) ")
                        .bold()
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: fullView.size.width * 0.7, height: fullView.size.width * 0.3)
                        .background(.red)
                        .cornerRadius(30)
                    
                    Spacer()
                    Button {
                        
                        feedback.notificationOccurred(.success)//for haptics notification
                        rollDice()
                    } label: {
                        Text("Roll Dice")
                            .frame(width:fullView.size.width * 0.8)
                            .padding()
                            .font(.title)
                            .background(.white)
                            .clipShape(Capsule())
                    }
                    Spacer()
                }
                .frame(width:fullView.size.width, height: fullView.size.height)
                .background(LinearGradient(colors: [.yellow,.red], startPoint: .top, endPoint: .bottom))
                
            }.navigationBarTitle("RollTheDice", displayMode:.inline)
                .ignoresSafeArea()
        }
    }
    
    func rollDice() {
        prevIndexNo = totalOfIndex
        indexNo = Int.random(in: 0..<diceNames.count)
        totalOfIndex = totalOfIndex + (indexNo + 1)
        feedback.prepare()// for haptics nitifications
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
