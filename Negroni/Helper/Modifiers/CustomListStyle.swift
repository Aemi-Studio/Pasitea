//
//  SwiftUIView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 28/10/23.
//

import SwiftUI

struct CustomListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowSpacing(8)
            .listItemTint(.accent)
            .listSectionSpacing(0)
            .listRowBackground( EmptyView() )
            .scrollContentBackground(.hidden)
            .padding(0)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    EditButton()
                }
            }
    }
}

extension View {
    func customListStyle() -> some View {
        modifier(CustomListStyle())
    }
}
