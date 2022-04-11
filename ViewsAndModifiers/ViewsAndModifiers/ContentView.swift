//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Amruta on 15/06/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       Color.blue
        .frame(width: 300, height: 200)
        .watermarked(with: "Hacking with Swift")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Custum modifier
struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        
        ZStack() {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

//extesion of view
extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}
