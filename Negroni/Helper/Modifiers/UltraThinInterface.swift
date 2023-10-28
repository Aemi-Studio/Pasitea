//
//  UltraThinInterface.swift
//  Negroni
//
//  Created by Guillaume Coquard on 27/10/23.
//

import SwiftUI

struct UltraThinInterface: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
    }
}

extension View {
    func ultraThinInterface() -> some View {
        modifier(UltraThinInterface())
    }
}
