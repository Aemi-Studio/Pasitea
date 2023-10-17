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
    @State private var id = 0

    var body: some View {
        NavigationView {
            if id < modelData.calmSteps.count {
                let step: CalmStep = modelData.calmSteps[id]
                VStack {
                    Text("Step \(id)")
                    Text(step.headline)
                    Text(step.subheadline)
                    Button("Next",action: getAScreen)
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
                Text("End of content")
            }
        }
    }

    func getAScreen() {
        $id.wrappedValue += 1
    }
}






