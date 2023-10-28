//
//  CustomBackButton.swift
//  Negroni
//
//  Created by Guillaume Coquard on 18/10/23.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.modelContext) var modelContext

    @State private var alertPresented = false

    var trackItem: TrackItem?

    var dismissAction: DismissAction?
    var customAction: (() -> Void)?

    var enforce: Bool = true
    var display: Bool = true

    var body: some View {
        HStack {
            Spacer()
            if display {
                Button(role: .none) {
                    if enforce {
                        alertPresented = true
                    } else {
                        if trackItem != nil {
                            TrackItem(trackItem!).saveInto(modelContext)
                        }
                        dismissAction?()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .scaledToFit()
                        .padding([.top, .bottom], 11)
                        .padding([.leading, .trailing], 18)
                        .foregroundStyle(Color.accentColor)
                        .accessibilityLabel("Close")
                }
            } else {
                EmptyView()
                    .frame(height: 48)
            }
        }
        .confirmationDialog(
            "You're about to exit an ongoing exercise. Are you sure about it?",
            isPresented: $alertPresented
        ) {
            Button(role: .destructive) {
                // Save the exercise
                trackItem?.saveInto(modelContext)

                if dismissAction != nil {
                    dismissAction?()
                } else if customAction != nil {
                    customAction?()
                }
            } label: {
                Text("Yes")
            }
        } message: {
            Text("You're about to exit an ongoing exercise.\nAre you sure about it?")
        }
        .navigationBarBackButtonHidden()
    }
}

#if DEBUG
#Preview {
    CustomBackButton( trackItem: TrackItem() )
}
#endif
