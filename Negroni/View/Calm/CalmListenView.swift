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
        ZStack {
            LightGradientView()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 64) {
                BigButton(image: Image(systemName:"waveform"))
                Text("Listen to this song")
                    .font(.title)
                    .bold()
            }
            VStack {
                CustomBackButton(dismissAction: dismiss)
                Spacer()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
#Preview {
    CalmListenView()
}

