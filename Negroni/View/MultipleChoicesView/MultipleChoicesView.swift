//
//  MultipleChoicesView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct MultipleChoicesView: View {

    @Environment(\.dismiss) var dismiss
    @State private var isBreathingExercisePresented = false
    @State private var isListeningExercisePresented = false
    @State private var isTrackingPresented = false

    var lastExercise: TrackItem.TrackType.RawValue

    var body: some View {
        ZStack {
            LightGradientView()
                .edgesIgnoringSafeArea(.all)

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
                        CalmBreatheView()
                    }


                    MultipleChoicesItemView(
                        title: "Listen",
                        subtitle: "Lorem ipsum dolor sit amet",
                        isViewPresented: $isListeningExercisePresented
                    )
                    .navigationDestination(isPresented: $isListeningExercisePresented) {
                        CalmListenView()
                    }


                    MultipleChoicesItemView(
                        title: "Keep Track",
                        subtitle: "Lorem ipsum dolor sit amet",
                        isViewPresented: $isTrackingPresented
                    )
                    .sheet(isPresented: $isTrackingPresented) {
                        TrackItemAddView()
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

#Preview {
    MultipleChoicesView(lastExercise: "steps")
}
