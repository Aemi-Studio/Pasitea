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

                LightGradientView()

                VStack(spacing: 96) {
                    Button {
                        isSteppedExercisePresented = true
                    } label: {
                        BigButton(title: "Calm Down")
                    }.navigationDestination(isPresented: $isSteppedExercisePresented) {
                        CalmDynamicView(
                            currentTrackItem: TrackItem(
                                type: TrackItem.TrackType.steps.rawValue
                            )
                        )
                    }

                    HStack(spacing: 32) {

                        Button {
                            isBreathingExercisePresented = true
                        } label: {
                            Text("Breathe")
                        }.navigationDestination(isPresented: $isBreathingExercisePresented) {
                            CalmBreatheView(
                                currentTrackItem: TrackItem(
                                    type: TrackItem.TrackType.breathing.rawValue
                                )
                            )
                        }
                        .buttonStyle(.borderedProminent)

                        Button {
                            isListeningExercisePresented = true
                        } label: {
                            Text("Listen")
                        }.navigationDestination(isPresented: $isListeningExercisePresented) {
                            CalmListenView(
                                currentTrackItem: TrackItem(
                                    type: TrackItem.TrackType.listening.rawValue
                                )
                            )
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

#if DEBUG
#Preview {
    CalmHome()
}
#endif
