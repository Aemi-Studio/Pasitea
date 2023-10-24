//
//  CalmStepView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 18/10/23.
//

import SwiftUI

struct CalmStepView: View {

    @Environment(ModelData.self) var modelData

    let step: CalmStep
    let getNextScreen: (() -> Void)?

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                Text(step.headline)
                    .font(.title)
                    .bold()
                Text(step.subheadline)
                    .font(.title2)
            }
            Spacer()
            (
                step.id != 4
                ? Button("Next",action: getNextScreen!)
                : Button("Finish",action: getNextScreen!)
            )
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 20)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            Spacer()
        }
        .background {
            Image(step.image)
                .resizable()
                .scaledToFit()
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.hidden, for: .tabBar)
    }
}

#if DEBUG
#Preview {
    CalmStepView(step:ModelData().calmSteps[0], getNextScreen: {})
        .environment(ModelData())
}
#endif
