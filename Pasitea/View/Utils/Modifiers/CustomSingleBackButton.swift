//
//  CustomSingleBackButton.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 30/10/23.
//

import SwiftUI

///
/// Single Back Button Style
///
struct CustomSingleBackButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .labelStyle(.iconOnly)
            .dynamicTypeSize(.xxLarge)
            .padding(.vertical, 11)
            .padding(.horizontal, 18)
            .foregroundStyle(Color.accentColor)
    }
}

extension View {
    func customSingleBackButton() -> some View {
        modifier(CustomSingleBackButton())
    }
}
