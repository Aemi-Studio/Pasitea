//
//  PasiteaSubheadlineStyle.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 30/10/23.
//

import SwiftUI

struct PasiteaSubheadlineStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.bold)
    }
}

extension View {
    func pasiteaSubheadlineStyle() -> some View {
        modifier(PasiteaSubheadlineStyle())
    }
}
