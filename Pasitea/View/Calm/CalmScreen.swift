//
//  CalmScreen.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmScreen: View {
    @State private var isSteppedExercisePresented = false
    @State private var isBreathingExercisePresented = false
    @State private var isListeningExercisePresented = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 16) {
                    Button {
                        withAnimation {
                            isSteppedExercisePresented = true
                        }
                    } label: {
                        Spacer()
                        Text("5 Steps")
                            .padding(.vertical, 16)
                        Spacer()
                    }
                    .font(.title)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                    .shadow(color: .white.opacity(0.2), radius: 20, x: 0, y: 5)
                    .frame(maxWidth: .infinity)

                    HStack(spacing: 16) {
                        Button {
                            withAnimation {
                                isBreathingExercisePresented = true
                            }
                        } label: {
                            Spacer()
                            Text("Breathe")
                                .padding(.vertical, 16)
                            Spacer()
                        }
                        .font(.title)
                        .fontDesign(.serif)
                        .fontWeight(.bold)

                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: 20))
                        .frame(maxWidth: .infinity)

                        Button {
                            withAnimation {
                                isListeningExercisePresented = true
                            }
                        } label: {
                            Spacer()
                            Text("Listen")
                                .padding(.vertical, 16)
                            Spacer()
                        }
                        .font(.title)
                        .fontDesign(.serif)
                        .fontWeight(.bold)
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
                .fullScreenCover(isPresented: $isListeningExercisePresented) {
                    CalmListenView()
                }
                .fullScreenCover(isPresented: $isBreathingExercisePresented) {
                    CalmBreatheView()
                }
                .fullScreenCover(isPresented: $isSteppedExercisePresented) {
                    CalmStepsView()
                }

                VStack {
                    CustomBackButton(display: .info) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Calm")
                                .font(.title2)
                                .fontDesign(.serif)
                                .fontWeight(.bold)
                            Group {
                                Text("""
The three buttons of this screen provides 3 types of exercises or actions that can help you calm down or manage your anxiety.
""")
                            }
                            .multilineTextAlignment(.leading)
                            .fontWeight(.medium)
                        }
                        .padding()
                        .informationModalStyle()
                    }
                    Spacer()
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

#if DEBUG
#Preview {
    CalmScreen()
}
#endif
