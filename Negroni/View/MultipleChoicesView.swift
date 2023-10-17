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

    var body: some View {
        VStack {
            Spacer()
            List {
                VStack(alignment: .leading) {
                    Text("Breathe")
                        .font(.headline)
                    Text("Lorem ipsum dolor sit amet")
                        .font(.subheadline)
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Listen to calm sounds")
                        .font(.headline)
                    Text("Lorem ipsum dolor sit amet")
                        .font(.subheadline)
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("Keep track of your mood")
                        .font(.headline)
                    Text("Lorem ipsum dolor sit amet")
                        .font(.subheadline)
                }
                .padding()

            }
            .listRowSpacing(20)
            Spacer()
        }
    }
}

#Preview {
    MultipleChoicesView(lastExercise: .Steps)
}
