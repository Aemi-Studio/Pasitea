//
//  CustomBackButton.swift
//  Negroni
//
//  Created by Guillaume Coquard on 18/10/23.
//

import SwiftUI

struct CustomBackButton: View {

    @State private var alertPresented = false

    var dismissAction: DismissAction? = nil
    var enforce: Bool = true
    var display: Bool = true

    var body: some View {
        HStack {
            Spacer()

            if display {
                Button(role: .none) {
                    if (enforce) {
                        alertPresented = true
                    } else {
                        dismissAction?()
                    }
                } label: {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width:24,height:24)
                            .scaledToFit()
                            .padding(16)
                            .foregroundStyle(.foreground)
                    }
                }
            } else {
                EmptyView()
                    .frame(height: 48)
            }
        }.confirmationDialog("Exiting the exercise", isPresented: $alertPresented) {
            Button("Yes", role: .destructive, action: { dismissAction?() })
        } message: {
            Text("Are you sure?")
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CustomBackButton()
}
