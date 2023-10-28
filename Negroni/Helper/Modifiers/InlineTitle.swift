//
//  InlineTitle.swift
//  Negroni
//
//  Created by Guillaume Coquard on 27/10/23.
//

import SwiftUI

struct InlineTitle: ViewModifier {
    var text: Text

    func body(content: Content) -> some View {
        content
            .navigationTitle(self.text)
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    func inlineTitle(_ text: Text) -> some View {
        modifier(InlineTitle(text: text))
    }
    func inlineTitle(_ text: String) -> some View {
        modifier(InlineTitle(text: Text(text)))
    }
}
