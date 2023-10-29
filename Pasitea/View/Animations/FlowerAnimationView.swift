//
//  FlowerAnimationView.swift
//  Pasitea
//
//  Created by Antonio Abbatiello on 25/10/23.
//

import SwiftUI
import Combine

struct FlowerAnimationView: View {
    @State private var isRunning = false
    @State private var isDone = false
    @State private var isFlowerOpen = false
    @State private var isFlowerOpenForText = false
    @State private var isPreparing = true
    #if DEBUG
    @State private var minutes: Double = 2
    #else
    @State private var minutes: Double = 5
    #endif
    @State private var animationDuration: Double = 5
    @State private var animationSteps: Double = 100
    @State private var breatheCount: Double = 0

    var numberOrBreathing: Double {
        minutes * 60 / animationDuration
    }
    var timer: Publishers.Autoconnect<Timer.TimerPublisher> { Timer.publish(every: animationDuration / animationSteps, on: .main, in: .common).autoconnect() }

    var flowerAnimation: Animation {
        isRunning
            ? .easeInOut(duration: animationDuration)
            .repeatCount(Int(numberOrBreathing))
            : .easeInOut(duration: 1)
    }

    var textAnimation: Animation {
        isRunning
            ? .timingCurve(0, 1, 0, 1, duration: animationDuration)
            .repeatCount(Int(numberOrBreathing))
            : .timingCurve(0, 1, 0, 1, duration: 1)
    }

    var countAnimation: Animation {
        isRunning
            ? .linear(duration: animationDuration)
            .repeatCount(Int(numberOrBreathing))
            : .linear(duration: 1)
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
                if !isDone {
                    Group {
                        Text( !isPreparing
                                ? isRunning
                                ? "Breathe Out"
                                : "Restart when you're ready"
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
                } else {
                    Text("Finished!")
                }
            }
            .font(.title)
            .fontDesign(.serif)
            .fontWeight(.bold)
            .frame(height: 64)

            Button("Breathing") {
                DispatchQueue.global(qos: .background).async {
                    if isPreparing {
                        isPreparing = false
                    } else if !isRunning {
                        breatheCount = 0
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
            .foregroundStyle(.clear)
            .font(.title3)
            .fontWeight(.semibold)
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: 16))
            .controlSize(.large)
            .background {
                GeometryReader { geo in
                    ProgressView(value: Double(breatheCount), total: Double(numberOrBreathing)) {
                        Label(isPreparing ? "Play" : isRunning ? "Stop" : "Restart",
                              systemImage: isPreparing ? "play" : isRunning ? "stop" : "arrow.clockwise")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    .onReceive(timer) { _ in
                        if isRunning {
                            if breatheCount < numberOrBreathing {
                                withAnimation {
                                    breatheCount += 1 / animationSteps
                                }
                            } else {
                                withAnimation {
                                    isRunning = false
                                    isDone = true
                                }
                            }
                        }
                    }
                    .progressViewStyle(CustomProgressStyle())
                    .frame(width: geo.size.width, height: geo.size.height)
                    .scaledToFill()
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    FlowerAnimationView()
}
