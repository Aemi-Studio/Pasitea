//
//  CalmSingleStepView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 18/10/23.
//

import SwiftUI

struct CalmSingleStepView: View {
    @Environment(ModelData.self) var modelData

    @Binding var step: Int
    var getNextScreen: (() -> Void)?
    var calmStep: CalmStep {
        if step < modelData.calmSteps.count {
            return modelData.calmSteps[step]
        }
        return modelData.calmSteps[modelData.calmSteps.count - 1]
    }

    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                VStack(spacing: 16) {
                    Text(calmStep.headline)
                        .font(.title)
                        .fontDesign(.serif)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text(calmStep.subheadline)
                        .font(.headline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(height: 160)
            Spacer()
            HStack(alignment: .center) {
                (
                    calmStep.id != 4
                        ? Button("Next", systemImage: "arrow.right.circle.fill", action: getNextScreen!)
                        : Button("Finish", systemImage: "checkmark.circle.fill", action: getNextScreen!)
                )
                .font(.title3)
                .fontWeight(.semibold)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 16))
                .controlSize(.large)
            }
            .frame(height: 160)
            Spacer()
        }
        .background {
            Image(calmStep.image)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        }
    }
}
