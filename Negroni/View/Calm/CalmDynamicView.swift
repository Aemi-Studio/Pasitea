//
//  CalmDynamicView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation
import SwiftUI
import SwiftData

struct CalmDynamicView: View {

    @Environment(ModelData.self) private var modelData
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var selection = 0
    @State private var lastStep = false
    @State private var exerciseFinished = false
    @State private var tags: [String] = []

    var currentTrackItem: TrackItem

    func getNextScreen() {
        currentTrackItem.tags.append("\(selection)")
        if selection == modelData.calmSteps.count - 1 {
            exerciseFinished = true
        } else {
            selection += 1
            lastStep = selection == modelData.calmSteps.count - 1
        }
    }
    
    var body: some View {
        ZStack {
            LightGradientView()
            
            VStack(spacing: 10) {
                TabView(selection: $selection) {
                    ForEach(modelData.calmSteps) { step in
                        CalmStepView(
                            step: step,
                            getNextScreen: getNextScreen
                        )
                            .tag(step.id)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .navigationDestination(isPresented: $exerciseFinished) {
                    CalmExerciseFinishedView(
                        currentTrackItem: currentTrackItem,
                        dismiss: dismiss
                    )
                }
            }
            
            VStack {
                CustomBackButton(
                    currentTrackItem: currentTrackItem,
                    dismissAction: dismiss,
                    display: !lastStep
                )
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
    CalmDynamicView(
        currentTrackItem: TrackItem()
    )
        .environment(ModelData())
}
#endif


