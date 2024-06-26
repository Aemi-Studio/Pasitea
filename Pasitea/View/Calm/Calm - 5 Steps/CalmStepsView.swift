//
//  CalmStepsView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation
import SwiftUI
import SwiftData

struct CalmStepsView: View {
    @Environment(ModelData.self) private var modelData
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.customDismiss) var customDismiss

    @State private var currentStep: Int = 0
    @State private var lastStep: Bool = false
    @State private var exerciseFinished: Bool = false

    private var trackItem: TrackItem = TrackItem(type: .steps, tags: [0.description])

    func getNextScreen() -> Binding<Int> {
        if currentStep > 0 {
            trackItem.addTags(currentStep.description)
        }

        withAnimation {
            currentStep += 1
        }

        if lastStep {
            withAnimation {
                exerciseFinished = true
            }
        } else {
            withAnimation {
                lastStep = currentStep == modelData.calmSteps.count - 1
            }
        }

        return $currentStep
    }

    var body: some View {
        ZStack {
            GradientView()

            VStack(spacing: 10) {
                CalmSingleStepView( step: $currentStep, getNextScreen: getNextScreen )
            }

            VStack {
                CustomBackButton(
                    trackItem: trackItem,
                    dismissAction: dismiss,
                    customDismiss: customDismiss,
                    enforce: false,
                    display: !lastStep ? [.info, .close] : .info
                ) {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("5-steps")
                            .font(.title2)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                        Group {
                            Text("""
The 5-4-3-2-1 method is a scientifically proven quick anxiety and stress reduction technique.

To calm down:

1. See: Identify 5 things around you.
2. Touch: Acknowledge 4 things you can physically feel.
3. Hear: Note 3 sounds in your environment.
4. Smell: Focus on 2 scents.
5. Taste: Experience 1 taste, like a sip of water.

Engaging your senses this way helps you stay present and reduce anxiety.
""")
                        }
                        .multilineTextAlignment(.leading)
                        .fontWeight(.medium)
                    }
                    .padding()
                    .informationModalStyle()
                }
                Spacer()
            }
        }
        .ultraThinInterface()
        .customCover(isPresented: $exerciseFinished, transition: .blur, animation: .easeInOut(duration: 2)) {
            CalmExerciseFinishedView(
                trackItem: TrackItem( trackItem ).endsNow(),
                dismiss: dismiss,
                customDismiss: customDismiss
            )
        }
    }
}

#if DEBUG
#Preview {
    CalmStepsView()
        .environment(ModelData())
}
#endif
