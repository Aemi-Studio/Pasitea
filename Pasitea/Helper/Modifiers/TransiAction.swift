//
//  TransiAction.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 28/10/23.
//

import SwiftUI

struct TransiAction: ViewModifier {
    func body(content: Content) -> some View {
        content
            .transaction { transaction in
                transaction.disablesAnimations = true
                transaction.animation = .easeInOut(duration: 0.5)
            }
    }
}

extension View {
    func transiAction() -> some View {
        modifier(TransiAction())
    }
}
