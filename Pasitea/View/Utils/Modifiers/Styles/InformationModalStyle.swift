//
//  InformationModalStyle.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 30/10/23.
//

import SwiftUI

struct InformationModalStyle: ViewModifier {
    var pasitea: Bool = true
    func body(content: Content) -> some View {
        if pasitea {
            content
                .pasitea()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        } else {
            content
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
}

extension View {
    func informationModalStyle(_ pasitea: Bool = true) -> some View {
        modifier(InformationModalStyle(pasitea: pasitea))
    }
}
