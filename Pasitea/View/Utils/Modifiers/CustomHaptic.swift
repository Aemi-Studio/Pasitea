//
//  CustomHaptic.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 01/11/23.
//

import SwiftUI

struct CustomHaptic<E: Equatable>: ViewModifier {
    var trigger: E

    var flexibility: SensoryFeedback.Flexibility = .rigid
    var intensity: Double = 0.75

    func body(content: Content) -> some View {
        content
            .sensoryFeedback(.impact(flexibility: flexibility, intensity: intensity), trigger: trigger)
    }
}

extension View {
    func customHaptic<E: Equatable>(_ trigger: E) -> some View {
        modifier(CustomHaptic(trigger: trigger))
    }

    func customHaptic<E: Equatable>(_ trigger: E, intensity: Double) -> some View {
        modifier(CustomHaptic(trigger: trigger, intensity: intensity))
    }

    func customHaptic<E: Equatable>(_ trigger: E, flexibility: SensoryFeedback.Flexibility) -> some View {
        modifier(CustomHaptic(trigger: trigger, flexibility: flexibility))
    }

    func customHaptic<E: Equatable>(_ trigger: E, flexibility: SensoryFeedback.Flexibility, intensity: Double) -> some View {
        modifier(CustomHaptic(trigger: trigger, flexibility: flexibility, intensity: intensity))
    }
}
