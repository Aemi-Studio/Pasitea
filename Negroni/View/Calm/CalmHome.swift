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
            VStack(spacing: 16) {
                Button {
                    isSteppedExercisePresented = true
                } label: {
                    Spacer()
                    Text("5 Steps")
                        .padding(.vertical, 16)
                    Spacer()
                }
                .font(.title)
                .fontDesign(.serif)
                .fontWeight(.bold)
                .fullScreenCover(isPresented: $isSteppedExercisePresented) {
                    CalmStepsView()
                }
                .transiAction()
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 20))
                .shadow(color: .white.opacity(0.2), radius: 20, x: 0, y: 5)
                .frame(maxWidth: .infinity)

                HStack(spacing: 16) {
                    Button {
                        isBreathingExercisePresented = true
                    } label: {
                        Spacer()
                        Text("Breathe")
                            .padding(.vertical, 16)
                        Spacer()
                    }
                    .font(.title)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .fullScreenCover(isPresented: $isBreathingExercisePresented) {
                        CalmBreatheView()
                    }
                    .transiAction()
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                    .frame(maxWidth: .infinity)

                    Button {
                        isListeningExercisePresented = true
                    } label: {
                        Spacer()
                        Text("Listen")
                            .padding(.vertical, 16)
                        Spacer()
                    }
                    .font(.title)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .fullScreenCover(isPresented: $isListeningExercisePresented) {
                        CalmListenView()
                    }
                    .transiAction()
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                    .frame(maxWidth: .infinity)
                }

                VStack(alignment: .center) {
                    Text("You can click on one of these buttons to start a calming exercise.")
                        .font(.headline)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .padding()
            .pasitea()
        }
        .ignoresSafeArea(.all)
    }
}

#if DEBUG
#Preview {
    CalmHome()
}
#endif
