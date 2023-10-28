//
//  ColorGradient.swift
//  Negroni
//
//  Created by Guillaume Coquard on 27/10/23.
//

import SwiftUI

struct ColorGradient: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .customBackground.opacity(0.6),
                .secondAccent.opacity(0.1)
            ]),
            startPoint: .bottom,
            endPoint: .top
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ColorGradient()
}
