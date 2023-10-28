//
//  BigButtonCircle.swift
//  Negroni
//
//  Created by Guillaume Coquard on 26/10/23.
//

import SwiftUI

struct BigButtonRectangle: View {
    var color: Color
    var rectSize: Double
    var opacityAmount: Double
    var effectAmount: Double
    var effectBlur: Double

    var body: some View {
        Circle()
            .scaledToFit()
            .padding(.horizontal, rectSize * 0.2)
            .foregroundColor(color)
            .opacity(opacityAmount - effectAmount)
            .scaleEffect(effectAmount)
            .blur(radius: 1.5 * effectBlur)
    }
}

#Preview {
    BigButtonRectangle(
        color: .accentColor,
        rectSize: 200,
        opacityAmount: 1.0,
        effectAmount: 1.5,
        effectBlur: 30
    )
}
