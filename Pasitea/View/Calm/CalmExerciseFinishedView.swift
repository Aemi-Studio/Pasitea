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
    var customDismiss: CustomDismiss?

    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                VStack(spacing: 20) {
                    Text("Exercise Finished")
                        .font(.title)
                        .fontDesign(.serif)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("Do you still need help ?")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(height: 160)
            Spacer()
            HStack(alignment: .center) {
                VStack(spacing: 20) {
                    Button( "I need more help", systemImage: "hand.raised.circle.fill") {
                        trackItem.saveInto(modelContext)
                        withAnimation {
                            isPresented = true
                        }
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 16))
                    .controlSize(.large)

                    Button( "I'm fine", systemImage: "hand.thumbsup.circle.fill" ) {
                        trackItem.saveInto(modelContext)
                        withAnimation {
                            dismissAction()
                            dismiss?()
                            customDismiss?()
                        }
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 16))
                    .controlSize(.large)
                }
            }
            .frame(height: 160)
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .pasitea()
        .sheet(isPresented: $isPresented) {
            MultipleChoicesView( trackItem: trackItem )
                .presentationDetents([.medium])
        }
    }
}

#if DEBUG
#Preview {
    CalmExerciseFinishedView( trackItem: TrackItem() )
}
#endif
