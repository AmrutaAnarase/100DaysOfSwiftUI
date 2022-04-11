 //
//  ContentView.swift
//  VoiceOver
//
//  Created by Amruta on 26/05/21.
//

import SwiftUI

struct ContentView: View {
   
    @State private var rating = 3
    var body: some View {

        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
