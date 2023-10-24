//
//  CalmExerciseFinishedView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmExerciseFinishedView: View {

    @Environment(\.dismiss) var dismissAction
    @Environment(\.modelContext) var modelContext

    @State private var isPresented = false

    @State private var alreadySaved = false

    private func saveTrackItem() {
        if !self.alreadySaved {
            self.alreadySaved = true
            self.currentTrackItem.endDate = Date.now
            self.modelContext.insert(self.currentTrackItem)
        }
    }

    var currentTrackItem: TrackItem

    var dismiss: DismissAction?

    var body: some View {
        ZStack {

            LightGradientView()

            VStack {
                Spacer()
                VStack(spacing: 20) {
                    Text("Exercise Finished")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text("Do you still need help ?")
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
                Spacer()
                HStack(spacing:20) {
                    Button(
                        "Yes",
                        systemImage: "questionmark.circle.fill",
                        action: {
                            self.saveTrackItem()
                            isPresented = true
                        }
                    )
                    .buttonStyle(.borderedProminent)
                    .navigationDestination(isPresented: $isPresented) {
                        MultipleChoicesView(
                            currentTrackItem: currentTrackItem
                        )
                    }

                    Button(
                        "I'm fine.",
                        systemImage: "checkmark.circle.fill",
                        action: {
                            self.saveTrackItem()
                            dismissAction()
                            dismiss?()
                        }
                    )
                    .buttonStyle(.borderedProminent)
                }
                Spacer()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden()
    }
}


#if DEBUG
#Preview {
    CalmExerciseFinishedView(
        currentTrackItem: TrackItem()
    )
}
#endif
