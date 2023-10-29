//
//  PasiteaFullScreenCover.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 29/10/23.
//

import SwiftUI

struct CustomCover<Content: View>: View {
    @Binding var isPresented: Bool
    @ViewBuilder var content: Content
    var animation: Animation

    var body: some View {
        ZStack {
            content
                .environment(\.customDismiss, CustomDismiss {
                    withAnimation(animation) {
                        isPresented = false
                    }
                })
        }
    }
}

extension View {
    func customCover<Content>(
        isPresented: Binding<Bool>,
        transition: AnyTransition = .blur,
        animation: Animation = .linear(duration: 0.5),
        content: @escaping () -> Content
    ) -> some View where Content: View {
        self
            .overlay {
                if isPresented.wrappedValue {
                    CustomCover(isPresented: isPresented, content: content, animation: animation)
                        .transition(transition)
                }
            }
    }
}

struct CustomDismiss {
    private var action: () -> Void
    func callAsFunction() {
        action()
    }

    init(action: @escaping () -> Void = { }) {
        self.action = action
    }
}

struct CustomDismissKey: EnvironmentKey {
    static var defaultValue: CustomDismiss = CustomDismiss()
}

extension EnvironmentValues {
    var customDismiss: CustomDismiss {
        get { self[CustomDismissKey.self] }
        set { self[CustomDismissKey.self] = newValue }
    }
}
