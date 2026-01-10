//
//  CalmExerciseFinishedView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftData
import SwiftUI

struct CalmExerciseFinishedView: View {
    @Environment(\.dismiss) var dismissAction
    @Environment(\.modelContext) var modelContext: ModelContext
    private var persistence: PersistenceFacade { PersistenceFacade(modelContext: modelContext) }

    @State private var isPresented = false

    var trackItem: TrackItem

    var dismiss: DismissAction?
    var customDismiss: CustomDismiss?

    var body: some View {
        ZStack {
            GradientView()

            VStack {
                Spacer()
                HStack(alignment: .center) {
                    PasiteaHeadlines(
                        "Exercise Finished",
                        subheadline: "Do you still need help ?"
                    )
                }
                .frame(height: 160)
                Spacer()
                HStack(alignment: .center) {
                    VStack(spacing: 20) {
                        Button("I need more help", systemImage: "hand.raised.circle.fill") {
                            persistence.save(trackItem)
                            withAnimation { isPresented.toggle() }
                        }
                        .pasiteaButtonStyle(.borderedProminent)

                        Button("I'm fine", systemImage: "hand.thumbsup.circle.fill") {
                            persistence.save(trackItem)
                            withAnimation {
                                dismissAction()
                                dismiss?()
                                customDismiss?()
                            }
                        }
                        .pasiteaButtonStyle(.bordered)
                    }
                }
                .frame(height: 160)
                Spacer()
            }
            .customHaptic(isPresented)
            .navigationBarBackButtonHidden()
        }
        .ultraThinInterface()
        .sheet(isPresented: $isPresented) {
            CalmChoicesView(trackItem: trackItem)
                .informationModalStyle(false)
        }
    }
}

#if DEBUG
#Preview {
    CalmExerciseFinishedView(trackItem: TrackItem())
}
#endif
