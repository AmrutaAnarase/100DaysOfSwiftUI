//
//  ContentView.swift
//  Drawing
//
//  Created by Amruta on 25/09/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import SwiftUI

///Challange
//1.Create an Arrow shape made from a rectangle and a triangle – having it point straight up is fine.
//2.Make the line thickness of your Arrow shape animatable.
//3.Create a ColorCyclingRectangle shape that is the rectangular cousin of ColorCyclingCircle, allowing us to control the position of the gradient using a property.
struct Tringle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        
        //below code is for arrow in one func
        //        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        //        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        //        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        //        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        //        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        //        path.addLine(to: CGPoint(x: rect.midX - 20, y: rect.maxY))
        //        path.addLine(to: CGPoint(x: rect.midX - 20, y: rect.midY))
        //        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        //        path.addLine(to: CGPoint(x: rect.midX + 20, y: rect.midY))
        //        path.addLine(to: CGPoint(x:rect.midX + 20, y: rect.maxY))
        //        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        //
        return path
    }
    
}

struct Rectangle1: Shape {
    var insetAmount: CGFloat
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - insetAmount, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX + insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x:rect.midX + insetAmount, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var body: some View {
        ZStack{
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    //.strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
    }
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}
struct ContentView: View {
    @State private var insetAmount:CGFloat = 20
    @State private var colorCycle = 0.0
    var body: some View {
        VStack{
            VStack(spacing: 0){
                
                Tringle()

                Rectangle1(insetAmount: insetAmount)
                    .onTapGesture {//animation for thikness
                        withAnimation(){
                            self.insetAmount = CGFloat.random(in: 30...40)
                        }
                    }
            }
         
            VStack{
            ColorCyclingRectangle(amount: self.colorCycle)
                .frame(width: 150, height: 150)
            
            Slider(value: $colorCycle)
            }
        }
        .frame(width: 300, height: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

