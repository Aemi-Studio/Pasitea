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

    func getNextScreen() {
        id += 1
    }

    var body: some View {

        var last = id >= modelData.calmSteps.count - 1

        CustomBackButton(dismissAction: dismiss, display: !last)

        VStack(spacing: 10) {

            Spacer()

            if id < modelData.calmSteps.count {
                CalmStepView(id: $id.wrappedValue, getNextScreen: getNextScreen)
            } else {
                CalmExerciseFinishedView()
            }

            Spacer()

        }
        .toolbar(.hidden, for: .tabBar)

    }
    
}


#Preview {
    CalmDynamicView()
        .environment(ModelData())
}



