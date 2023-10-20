//
//  MultipleChoicesView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct MultipleChoicesView: View {

    var dismissAction: DismissAction?
    var lastExercise: TrackItem.TrackType.RawValue
    @State private var isBreathingExercisePresented = false
    @State private var isListeningExercisePresented = false
    @State private var isTrackingPresented = false

    var body: some View {

        NavigationStack {

            ZStack {

                Color.blue.opacity(0.2).edgesIgnoringSafeArea(.all)

                VStack {

                    Text("Choose Next Action")
                        .font(.title)
                        .bold()
                        .padding([.top,.bottom],64)


                    VStack(spacing: 16) {

                        MultipleChoicesItemView(
                            title: "Breathe",
                            subtitle: "Lorem ipsum dolor sit amet",
                            isViewPresented: $isBreathingExercisePresented
                        )
                        .sheet(isPresented: $isBreathingExercisePresented) {
                            CalmBreatheView()
                                .presentationDetents([.large])
                                .presentationDragIndicator(.visible)
                                .presentationBackgroundInteraction(.disabled)
                        }

                        MultipleChoicesItemView(
                            title: "Listen",
                            subtitle: "Lorem ipsum dolor sit amet",
                            isViewPresented: $isListeningExercisePresented
                        )
                        .sheet(isPresented: $isListeningExercisePresented) {
                            CalmListenView()
                                .presentationDetents([.large])
                                .presentationDragIndicator(.visible)
                                .presentationBackgroundInteraction(.disabled)
                        }

                        MultipleChoicesItemView(
                            title: "Keep Track",
                            subtitle: "Lorem ipsum dolor sit amet",
                            isViewPresented: $isTrackingPresented
                        )
                        .sheet(isPresented: $isTrackingPresented) {
                            TrackItemAddView()
                                .presentationDetents([.large])
                                .presentationDragIndicator(.visible)
                                .presentationBackgroundInteraction(.disabled)
                        }


                        Spacer()

                    }

                    Spacer()

                }
                .padding()
            }
        }
    }
}

#Preview {
    MultipleChoicesView(lastExercise: "steps")
}
