//
//  OverFradient.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 27/10/23.
//

import SwiftUI

struct OverGradient: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LightGradientView()
            content
        }
    }
}

extension View {
    func overGradient() -> some View {
        modifier(OverGradient())
    }
}
