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
    @State var amount = 0.75
    
    var body: some View {
        NavigationStack {
            ZStack {

                LightGradientView()
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 96) {
                    Button {
                        isSteppedExercisePresented = true
                    } label: {
                        BigButton(title: "Calm Down")
                    }.navigationDestination(isPresented: $isSteppedExercisePresented) {
                        CalmDynamicView()
                            .toolbar(.hidden, for: .tabBar)
                    }

                    HStack(spacing: 32) {

                        Button {
                            isBreathingExercisePresented = true
                        } label: {
                            Text("Breathe")
                        }.navigationDestination(isPresented: $isBreathingExercisePresented) {
                            CalmBreatheView()
                                .toolbar(.hidden, for: .tabBar)
                        }
                        .buttonStyle(.borderedProminent)

                        Button {
                            isListeningExercisePresented = true
                        } label: {
                            Text("Listen")
                        }.navigationDestination(isPresented: $isListeningExercisePresented) {
                            CalmListenView()
                                .toolbar(.hidden, for: .tabBar)
                        }
                        .buttonStyle(.borderedProminent)

                    }
                }
                .padding()
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
        }
    }
}

#Preview {
    CalmHome()
}

/*
.animation(.easeOut(duration: 2) .repeatForever(autoreverses: false),
           value: amount
)
*/
