//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Amruta on 19/01/22.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red,.green,.pink,.orange,.yellow,.purple,.blue]
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
            ForEach(0..<50) { index in
                GeometryReader { geo in
                    Text("Row #\(index)")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .background(colors[index % 7])
                        .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0 , y: 1, z: 0))
                }
                .frame(height: 40)
            }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
           
    }
}
