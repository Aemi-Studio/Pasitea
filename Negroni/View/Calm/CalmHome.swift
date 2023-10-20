//
//  CalmHome.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmHome: View {

    @State private var isSteppedExercisePresented = false
    @State private var isBreathingExercisePresented = false
    @State private var isListeningExercisePresented = false

    var body: some View {
        NavigationStack {

            ZStack {
                Rectangle()
                    .fill(.background)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 96) {

                    Button {
                        isSteppedExercisePresented = true
                    } label: {
                        Text("Calm Down")
                            .font(.title)
                            .multilineTextAlignment(.center)
                            .kerning(-0.3)
                            .fontDesign(.rounded)
                            .fontWeight(.bold)
                            .padding([.top,.bottom], 10)
                            .padding([.leading,.trailing], 20)
                            .frame(width:cs,height:cs)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(.infinity)
                            .background {
                                ZStack {
                                    Circle()
                                        .frame(width:iCS(cs,1),height:iCS(cs,1))
                                        .opacity(0.25)
                                    Circle()
                                        .frame(width:iCS(cs,2),height:iCS(cs,2))
                                        .opacity(0.25)
                                    Circle()
                                        .frame(width:iCS(cs,3),height:iCS(cs,3))
                                        .opacity(0.25)
                                }
                            }
                    }.navigationDestination(isPresented: $isSteppedExercisePresented) {
                            CalmDynamicView()
                        }


                        HStack(spacing: 32) {

                            Button {
                                isBreathingExercisePresented = true
                            } label: {
                                Text("Breathe")
                            }.navigationDestination(isPresented: $isBreathingExercisePresented) {
                                CalmBreatheView()
                            }
                            .buttonStyle(.borderedProminent)

                            Button {
                                isListeningExercisePresented = true
                            } label: {
                                Text("Listen")
                            }.navigationDestination(isPresented: $isListeningExercisePresented) {
                                CalmListenView()
                            }
                            .buttonStyle(.borderedProminent)

                        }
                    }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    CalmHome()
}
