//
//  PasiteaStyle.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 27/10/23.
//

import SwiftUI

struct PasiteaStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .ultraThinInterface()
            .overGradient()
    }
}

extension View {
    func pasitea() -> some View {
        modifier(PasiteaStyle())
    }
}
