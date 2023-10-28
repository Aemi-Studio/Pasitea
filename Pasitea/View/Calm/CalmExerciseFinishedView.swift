//
//  CalmExerciseFinishedView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmExerciseFinishedView: View {
    @Environment(\.dismiss) var dismissAction
    @Environment(\.modelContext) var modelContext

    @State private var isPresented = false

    var trackItem: TrackItem

    var dismiss: DismissAction?

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                Text("Exercise Finished")
                    .font(.title)
                    .fontDesign(.serif)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("Do you still need help ?")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            VStack(spacing: 20) {
                Button( "I need more help", systemImage: "hand.raised.circle.fill") {
                    trackItem.saveInto(modelContext)
                    isPresented = true
                }
                .font(.title3)
                .fontWeight(.medium)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 12))
                .fullScreenCover(isPresented: $isPresented) {
                    MultipleChoicesView( trackItem: trackItem )
                }
                .transiAction()

                Button( "I'm fine", systemImage: "hand.thumbsup.circle.fill" ) {
                    trackItem.saveInto(modelContext)
                    dismissAction()
                    dismiss?()
                }
                .font(.title3)
                .fontWeight(.medium)
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle(radius: 12))
            }
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .pasitea()
    }
}

#if DEBUG
#Preview {
    CalmExerciseFinishedView( trackItem: TrackItem() )
}
#endif
