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
                ZStack(alignment: .center) {
                    Text(calmStep.items.description)
                        .font(.system(size: 156))
                        .fontDesign(.serif)
                        .fontWeight(.black)
                        .foregroundStyle(.secondary)
                        .shadow(color: .secondary.opacity(0.8), radius: 20, x: 0, y: 0)
                        .blendMode(.overlay)

                    VStack(spacing: 16) {
                        Text(calmStep.headline)
                            .font(.title2)
                            .fontDesign(.serif)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        if !calmStep.subheadline.isEmpty {
                            Text(calmStep.subheadline)
                                .font(.headline)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            }
            .frame(height: 128)
            Spacer(minLength: 16)
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    Label(calmStep.headline, systemImage: calmStep.image)
                        .font(.system(size: 60))
                        .foregroundStyle(.foreground)
                        .labelStyle(.iconOnly)
                }
                .frame(width: 160, height: 160)
            }
            Spacer(minLength: 16)
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
            .frame(height: 128)
            Spacer()
        }
        .transition(.blur)
    }
}
