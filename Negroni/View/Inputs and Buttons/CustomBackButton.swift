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

    var currentTrackItem: TrackItem?

    var dismissAction: DismissAction? = nil
    var customAction: (() -> Void)? = nil
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
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width:22,height:22)
                        .scaledToFit()
                        .padding([.top,.bottom], 11)
                        .padding([.leading,.trailing], 18)
                        .foregroundStyle(Color.accentColor)
                }
            } else {
                EmptyView()
                    .frame(height: 48)
            }
        }
        .confirmationDialog("Exiting the exercise", isPresented: $alertPresented) {
            Button("Yes", role: .destructive, action: {

                if currentTrackItem != nil {
                    currentTrackItem!.endDate = Date.now
                    modelContext.insert(currentTrackItem!)
                }

                if dismissAction != nil {
                    dismissAction?()
                } else if customAction != nil {
                    customAction?()
                }
            })
        } message: {
            Text("Are you sure?")
        }
        .navigationBarBackButtonHidden()
    }
}

#if DEBUG
#Preview {
    CustomBackButton(
        currentTrackItem: TrackItem(
            type: TrackItem.TrackType.none.rawValue
        )
    )
}
#endif
