//
//  MultipleChoiceItemView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 20/10/23.
//

import SwiftUI

struct MultipleChoicesItemView: View {
    
    var title: String
    var subtitle: String
    var isViewPresented: Binding<Bool>?
    
    var body: some View {
        HStack {
            Button {
                isViewPresented?.wrappedValue = true
            } label: {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(subtitle)
                        .font(.subheadline)
                }
                .padding()
                Spacer()
                Image(systemName: "chevron.right")
                    .padding()
            }
        }
        .foregroundColor(.primary)
        .background(Color.accentColor.opacity(0.4))
        .background(.thickMaterial)
        .cornerRadius(10)
    }
}

#Preview {
    MultipleChoicesItemView(title: "Lorem Ipsum",subtitle: "Lorem ipsum dolor sit amet")
}
