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

    @Binding var isViewPresented: Bool

    var body: some View {
        HStack {
            Button {
                isViewPresented = true
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
        .foregroundColor(.accent)
        .background(.regularMaterial)
        .cornerRadius(16)
        .shadow(color: Color.accentColor.opacity(0.05), radius: 16, x: 0, y: 8)
    }
}

#if DEBUG
struct MultipleChoicesItemView_Preview: PreviewProvider {
    @State var isPresented: Bool = false

    static var previews: some View {
        Group {
            MultipleChoicesItemView(
                title: "Lorem Ipsum",
                subtitle: "Lorem ipsum dolor sit amet",
                isViewPresented: .constant(true)
            )
            MultipleChoicesItemView(
                title: "Lorem Ipsum",
                subtitle: "Lorem ipsum dolor sit amet",
                isViewPresented: .constant(false)
            )
        }
    }
}
#endif
