//
//  LargeTitle.swift
//  Negroni
//
//  Created by Guillaume Coquard on 27/10/23.
//

import SwiftUI

struct LargeTitle: ViewModifier {
    var text: Text

    func body(content: Content) -> some View {
        content
            .navigationTitle(self.text)
            .navigationBarTitleDisplayMode(.large)
    }
}

extension View {
    func largeTitle(_ text: Text) -> some View {
        modifier(LargeTitle(text: text))
    }
    func largeTitle(_ text: String) -> some View {
        modifier(LargeTitle(text: Text(text)))
    }
}
