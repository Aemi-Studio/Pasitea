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

    var trackItem: TrackItem

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
                            trackItem: TrackItem(type: .breathing, previousId: trackItem.id)
                        )
                    }


                    MultipleChoicesItemView(
                        title: "Listen",
                        subtitle: "Lorem ipsum dolor sit amet",
                        isViewPresented: $isListeningExercisePresented
                    )
                    .navigationDestination(isPresented: $isListeningExercisePresented) {
                        CalmListenView(
                            trackItem: TrackItem(type: .listening, previousId: trackItem.id)
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
                            previousId: trackItem.id
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
    MultipleChoicesView( trackItem: TrackItem() )
}
#endif
