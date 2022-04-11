//
//  ContentView.swift
//  Animations
//
//  Created by Amruta on 29/06/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var isShowingRed = false
    
    var body: some View {
        VStack{
            Button("Tap me"){
                withAnimation {
                self.isShowingRed.toggle()
                }
            }
            if isShowingRed{
            Rectangle()
                .fill(Color.red)
                .frame(width: 200, height: 200)
                .transition(.pivot)
                
        }
        }
     
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}
extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
