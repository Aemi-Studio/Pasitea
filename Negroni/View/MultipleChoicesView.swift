//
//  MultipleChoicesView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct MultipleChoicesView: View {

    var dismissAction: DismissAction?
    var lastExercise: TrackItem.TrackType
    @State private var isBreathingExercisePresented = false
    @State private var isListeningExercisePresented = false
    @State private var isTrackingPresented = false

    var body: some View {

        HStack {

            Spacer()

            NavigationStack {

                VStack {

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Breathe")
                                .font(.headline)
                            Text("Lorem ipsum dolor sit amet")
                                .font(.subheadline)
                        }
                        .padding()
                        Spacer()
                        Image(systemName: "chevron.right")
                    }

                    HStack {
                        Button {
                            isListeningExercisePresented = true
                        } label: {
                            VStack(alignment: .leading) {
                                Text("Listen to calm sounds")
                                    .font(.headline)
                                Text("Lorem ipsum dolor sit amet")
                                    .font(.subheadline)
                            }
                            .padding()
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }.sheet(isPresented: $isListeningExercisePresented, onDismiss: {

                    }) {
                        CalmListenView()
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                            .presentationBackgroundInteraction(.disabled)
                    }

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Keep track of your mood")
                                .font(.headline)
                            Text("Lorem ipsum dolor sit amet")
                                .font(.subheadline)
                        }
                        .padding()
                        Spacer()
                        Image(systemName: "chevron.right")
                    }

                }

            }
            .background(.thickMaterial)

            Spacer()
        }

    }
}

#Preview {
    MultipleChoicesView(lastExercise: .Steps)
}
