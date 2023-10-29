//
//  CustomTransition.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 29/10/23.
//

import SwiftUI

// A general modifier that can clip any view using a any shape.
struct BlurModifier: ViewModifier {
    let blurValue: CGFloat
    let scaleValue: CGFloat

    func body(content: Content) -> some View {
        content
            .blur(radius: blurValue)
            .scaleEffect(scaleValue)
    }
}

// A custom transition combining ScaledCircle and ClipShapeModifier.
extension AnyTransition {
    static var blur: AnyTransition {
        .modifier(
            active: BlurModifier(blurValue: 20, scaleValue: 1.25),
            identity: BlurModifier(blurValue: 0, scaleValue: 1)
        )
    }
}
