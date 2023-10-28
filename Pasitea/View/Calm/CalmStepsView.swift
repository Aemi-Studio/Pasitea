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

    @State private var currentStep: Int = 0
    @State private var lastStep: Bool = false
    @State private var exerciseFinished: Bool = false

    private var trackItem: TrackItem = TrackItem(type: .steps, tags: [0.description])

    func getNextScreen() {
        if currentStep > 0 {
            trackItem.addTags(currentStep.description)
        }
        if lastStep {
            exerciseFinished = true
        } else {
            currentStep += 1
            lastStep = currentStep == modelData.calmSteps.count - 1
        }
    }

    var body: some View {
        ZStack {
            LightGradientView()

            VStack(spacing: 10) {
                CalmSingleStepView( step: $currentStep, getNextScreen: getNextScreen )
                    .fullScreenCover(isPresented: $exerciseFinished) {
                        CalmExerciseFinishedView(
                            trackItem: TrackItem( trackItem ).endsNow(),
                            dismiss: dismiss
                        )
                    }
                    .transiAction()
            }

            VStack {
                CustomBackButton(
                    trackItem: trackItem,
                    dismissAction: dismiss,
                    enforce: false,
                    display: !lastStep
                )
                Spacer()
            }
        }
        .ultraThinInterface()
    }
}

#if DEBUG
#Preview {
    CalmStepsView()
        .environment(ModelData())
}
#endif