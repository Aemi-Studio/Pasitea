//
//  SectionToLargeTitle.swift
//  Negroni
//
//  Created by Guillaume Coquard on 28/10/23.
//

import SwiftUI

struct SectionToLargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(0)
            .padding(.bottom, 16)
            .padding(.top, -17)
            .padding(.leading, (UIScreen.main.bounds.width / 1284) * -10 + -14)
            .textCase(.none)
            .font(.largeTitle)
            .fontDesign(.serif)
            .fontWeight(.bold)
            .foregroundStyle(.foreground)
    }
}

extension View {
    func sectionToLargeTitle() -> some View {
        modifier(SectionToLargeTitle())
    }
}
