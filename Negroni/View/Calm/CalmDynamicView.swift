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
    @State private var id = 0
    @State private var alertPresented = false
    @State private var backButtonPresented = true

    var body: some View {

        VStack(spacing: 10) {

            if backButtonPresented {
                HStack {
                    Button("Back", systemImage: "chevron.left", role: .cancel, action: { alertPresented = true })
                    Spacer()
                }.alert("Exiting the exercise", isPresented: $alertPresented) {
                    Button("OK", role: .destructive, action: { dismiss() })
                } message: {
                    Text("Are you sure?")
                }
            }

            NavigationStack {
                Spacer()
                if id < modelData.calmSteps.count - 1 {
                    let step = modelData.calmSteps[id]
                    VStack {
                        Text("Step \(id)")
                        Text(step.headline)
                        Text(step.subheadline)
                        Button("Next",action: getNextScreen)
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 20)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    }
                    .background {
                        Image(step.image)
                            .resizable()
                            .scaledToFit()
                    }
                } else if id == modelData.calmSteps.count - 1 {
                    let step = modelData.calmSteps[id]
                    VStack {
                        Text("Step \(id)")
                        Text(step.headline)
                        Text(step.subheadline)
                        Button("Finish",action: getNextScreen)
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 20)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    }
                    .background {
                        Image(step.image)
                            .resizable()
                            .scaledToFit()
                    }
                } else {
                    CalmExerciseFinishedView()
                }
                Spacer()
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
    }

    func getNextScreen() {
        $id.wrappedValue += 1
        if $id.wrappedValue == modelData.calmSteps.count - 1 {
            $backButtonPresented.wrappedValue = false
        }
    }
}






