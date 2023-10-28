//
//  MultipleChoicesView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct MultipleChoicesView: View {
    @State private var isBreathingExercisePresented = false
    @State private var isListeningExercisePresented = false
    @State private var isTrackingPresented = false

    @Environment(\.dismiss) var dismiss

    var trackItem: TrackItem

    var body: some View {
        ZStack {
            LightGradientView()

            VStack(spacing: 64) {
                Text("Choose Next Action")
                    .font(.title)
                    .fontDesign(.serif)
                    .bold()
                    .padding(.top)

                VStack(spacing: 16) {
                    MultipleChoicesItemView(
                        title: "Breathe",
                        subtitle: "Calm down with breathing exercises",
                        isViewPresented: $isBreathingExercisePresented
                    ).fullScreenCover(isPresented: $isBreathingExercisePresented) {
                        CalmBreatheView(
                            trackItem: TrackItem(type: .breathing, previousId: trackItem.id)
                        )
                    }

                    MultipleChoicesItemView(
                        title: "Listen",
                        subtitle: "Focus on calming sounds",
                        isViewPresented: $isListeningExercisePresented
                    )
                    .fullScreenCover(isPresented: $isListeningExercisePresented) {
                        CalmListenView(
                            trackItem: TrackItem(type: .listening, previousId: trackItem.id)
                        )
                    }

                    MultipleChoicesItemView(
                        title: "Keep Track",
                        subtitle: "Save your thoughts for later",
                        isViewPresented: $isTrackingPresented
                    )
                    .sheet(isPresented: $isTrackingPresented, content: {
                        TrackItemAddView( previousId: trackItem.id )
                    })

                    Spacer()
                }

                Spacer()
            }
            .padding(.top, 48)
            .padding()

            VStack {
                CustomBackButton(dismissAction: dismiss, enforce: false)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#if DEBUG
#Preview {
    MultipleChoicesView( trackItem: TrackItem() )
}
#endif
