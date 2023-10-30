//
//  BlurTransition.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 29/10/23.
//

import SwiftUI

struct BlurModifier: ViewModifier {
    let blurValue: CGFloat
    let scaleValue: CGFloat

    func body(content: Content) -> some View {
        content
            .blur(radius: blurValue)
            .scaleEffect(scaleValue)
    }
}

extension AnyTransition {
    static var blur: AnyTransition {
        .modifier(
            active: BlurModifier(blurValue: 20, scaleValue: 1.15),
            identity: BlurModifier(blurValue: 0, scaleValue: 1)
        )
    }
}
