//
//  CalmListenView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmListenView: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {

        CustomBackButton(dismissAction: dismiss)

        VStack {

            Spacer()

            Text("Listen")

            Spacer()
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    CalmListenView()
}
