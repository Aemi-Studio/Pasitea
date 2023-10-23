//
//  CalmDynamicView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation
import SwiftUI

struct CalmDynamicView: View {
    
    @Environment(ModelData.self) private var modelData
    @Environment(\.dismiss) var dismiss
    @State private var selection = 0
    @State private var lastStep = false
    @State private var exerciseFinished = false
    
    func getNextScreen() {
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
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                TabView(selection: $selection) {
                    ForEach(modelData.calmSteps) { step in
                        CalmStepView(step: step, getNextScreen: getNextScreen)
                            .tag(step.id)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
            }.navigationDestination(isPresented: $exerciseFinished) {
                CalmExerciseFinishedView(dismiss: dismiss)
            }
            
            VStack {
                CustomBackButton(dismissAction: dismiss, display: !lastStep)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    CalmDynamicView()
        .environment(ModelData())
}



