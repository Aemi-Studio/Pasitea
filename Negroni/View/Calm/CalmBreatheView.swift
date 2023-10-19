//
//  CalmBreatheView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmBreatheView: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {

        CustomBackButton(dismissAction: dismiss)

        VStack {

            Spacer()

            Text("Breathe")

            Spacer()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    CalmBreatheView()
}
