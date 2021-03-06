//
//  CardView.swift
//  Flashzilla
//
//  Created by Amruta on 05/01/22.
//

import SwiftUI

struct CardView: View {
    let card: Card
    @State private var isShowingAnswer = false
    //track how far the user has dragged
    @State private var offset = CGSize.zero
    //closure that accepts no parameters and sends nothing back, defaulting to nil so we don’t need to provide it unless it’s explicitly needed.
    var removal: (() -> Void)? = nil
    //to track whether we should be using color for this purpose or not
    ////this is for folks with color blindness
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    //for voiceover
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    //for haptic
    @State private var feedback = UINotificationFeedbackGenerator()
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width > 0 ? .green : .red)
                )
                .shadow(radius: 10)
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        //get haptics in our app
                        if offset.width > 0 {
                            feedback.notificationOccurred(.success)
                        } else {
                            feedback.notificationOccurred(.error)
                        }
                        // remove the card
                        removal?()
                        //That question mark in there means the closure will only be called if it has been set.
                    }
                    else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
        
    }
}
