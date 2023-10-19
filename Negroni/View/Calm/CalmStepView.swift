//
//  CalmStepView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 18/10/23.
//

import SwiftUI

struct CalmStepView: View {

    @Environment(ModelData.self) var modelData

    let id: Int?
    let getNextScreen: (() -> Void)?

    var body: some View {
        let step = modelData.calmSteps[id!]
        let last = id == modelData.calmSteps.count - 1

        VStack {
            Text("Step \(id!)")
            Text(step.headline)
            Text(step.subheadline)

            Button(last ? "Finish" : "Next",action: getNextScreen!)
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
    }
}

#Preview {
    CalmStepView(id: 0, getNextScreen: {})
        .environment(ModelData())
}
