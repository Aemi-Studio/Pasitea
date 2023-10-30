//
//  PasiteaButtonStyle.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 30/10/23.
//

import SwiftUI

struct PasiteaButtonStyle<S>: ViewModifier where S: PrimitiveButtonStyle {
    var buttonStyle: S
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(.semibold)
            .buttonStyle(buttonStyle)
            .buttonBorderShape(.roundedRectangle(radius: 16))
            .controlSize(.large)
    }
}

extension View {
    func pasiteaButtonStyle<S>(_ buttonStyle: S = .borderedProminent) -> some View where S: PrimitiveButtonStyle {
        modifier(PasiteaButtonStyle(buttonStyle: buttonStyle))
    }
}
