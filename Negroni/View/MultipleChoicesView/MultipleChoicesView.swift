//
//  MultipleChoicesView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct MultipleChoicesView: View {

    @State private var isBreathingExercisePresented = false
    @State private var isListeningExercisePresented = false
    @State private var isTrackingPresented = false

    @Environment(\.dismiss) var dismiss

    var currentTrackItem: TrackItem

    var body: some View {
        ZStack {

            LightGradientView()

            VStack(spacing: 64) {

                Text("Choose Next Action")
                    .font(.title)
                    .bold()

                VStack(spacing: 16) {

                    MultipleChoicesItemView(
                        title: "Breathe",
                        subtitle: "Lorem ipsum dolor sit amet",
                        isViewPresented: $isBreathingExercisePresented
                    ).navigationDestination(isPresented: $isBreathingExercisePresented) {
                        CalmBreatheView(
                            currentTrackItem: TrackItem(
                                type: TrackItem.TrackType.breathing.rawValue,
                                previousId: currentTrackItem.id
                            )
                        )
                    }


                    MultipleChoicesItemView(
                        title: "Listen",
                        subtitle: "Lorem ipsum dolor sit amet",
                        isViewPresented: $isListeningExercisePresented
                    )
                    .navigationDestination(isPresented: $isListeningExercisePresented) {
                        CalmListenView(
                            currentTrackItem: TrackItem(
                                type: TrackItem.TrackType.listening.rawValue,
                                previousId: currentTrackItem.id
                            )
                        )
                    }


                    MultipleChoicesItemView(
                        title: "Keep Track",
                        subtitle: "Lorem ipsum dolor sit amet",
                        isViewPresented: $isTrackingPresented
                    )
                    .navigationDestination(isPresented: $isTrackingPresented) {
                        TrackItemAddView(
                            isPresented: $isTrackingPresented,
                            previousId: currentTrackItem.id
                        )
                    }

                    Spacer()

                }

                Spacer()
            }
            .padding(.top,48)
            .padding()

            VStack {
                CustomBackButton(dismissAction: dismiss)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#if DEBUG
#Preview {
    MultipleChoicesView(
        currentTrackItem: TrackItem()
    )
}
#endif
