//
//  FlowerAnimationView.swift
//  Pasitea
//
//  Created by Antonio Abbatiello on 25/10/23.
//

import SwiftUI

struct FlowerAnimationView: View {
    @State private var isRunning = false
    @State private var isFlowerOpen = false
    @State private var isFlowerOpenForText = false
    @State private var isPreparing = true
    @State private var animationDuration: Double = 6

    var flowerAnimation: Animation {
        isRunning
            ? .easeInOut(duration: animationDuration)
            .repeatForever()
            : .easeInOut(duration: animationDuration)
    }

    var textAnimation: Animation {
        isRunning
            ? .timingCurve(0, 1, 0, 1, duration: animationDuration)
            .repeatForever()
            : .timingCurve(0, 1, 0, 1, duration: animationDuration)
    }

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 48) {
            ZStack {
                // Middle Left Petal - Second
                Image("flower")
                    .rotationEffect(.degrees( isFlowerOpen ? -25 : -5), anchor: .bottom)

                // Middle Right Petal - Fourth
                Image("flower")
                    .rotationEffect(.degrees( isFlowerOpen ? 25 : 5), anchor: .bottom)

                // Middle Petal - Third
                Image("flower")

                // Left Petal - First
                Image("flower")
                    .rotationEffect(.degrees( isFlowerOpen ? -50 : -10), anchor: .bottom)

                // Right Petal - Fifth
                Image("flower")
                    .rotationEffect(.degrees( isFlowerOpen ? 50 : 10), anchor: .bottom)
            }
            .shadow(radius: isFlowerOpen ? 20 : 0)
            .hueRotation(Angle(degrees: isFlowerOpen ? -170 : 0))

            ZStack {
                Group {
                    Text( !isPreparing
                            ? isRunning
                            ? "Breathe Out"
                            : "Resume when you're ready"
                            : "Prepare Yourself"
                    )
                    .blur(radius: isFlowerOpenForText ? 20 : 0)
                    .scaleEffect(isFlowerOpenForText ? 0.75 : 1, anchor: .center)
                    .opacity(isFlowerOpenForText ? 0 : 1)

                    Text("Breathe In")
                        .blur(radius: isFlowerOpenForText ? 0 : 20)
                        .scaleEffect(isFlowerOpenForText ? 1 : 0.75, anchor: .center)
                        .opacity(isFlowerOpenForText ? 1 : 0)
                }
            }
            .font(.title)
            .fontDesign(.serif)
            .fontWeight(.bold)
            .frame(height: 64)

            Button(
                isPreparing ? "Play" : isRunning ? "Pause" : "Resume",
                systemImage: isPreparing ? "play" : isRunning ? "pause" : "arrow.clockwise"
            ) {
                DispatchQueue.global(qos: .background).async {
                    if isPreparing {
                        isPreparing = false
                    }

                    isRunning.toggle()

                    withAnimation( flowerAnimation ) {
                        isFlowerOpen.toggle()
                    }

                    withAnimation( textAnimation ) {
                        isFlowerOpenForText.toggle()
                    }
                }
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .font(.headline)
            .fontWeight(.semibold)
        }
    }
}

#Preview {
    FlowerAnimationView()
}
