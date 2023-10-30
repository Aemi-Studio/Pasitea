//
//  PasiteaHeadlineStyle.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 30/10/23.
//

import SwiftUI

struct PasiteaHeadlineStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontDesign(.serif)
            .fontWeight(.bold)
    }
}

extension View {
    func pasiteaHeadlineStyle() -> some View {
        modifier(PasiteaHeadlineStyle())
    }
}
