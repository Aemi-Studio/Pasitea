//
//  BackgroundGradient.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 27/10/23.
//

import SwiftUI

struct BackgroundGradient: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            GradientView()
            content
        }
    }
}

extension View {
    func backgroundGradient() -> some View {
        modifier(BackgroundGradient())
    }
}
