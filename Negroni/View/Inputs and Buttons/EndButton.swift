//
//  EndButton.swift
//  Negroni
//
//  Created by Antonio Abbatiello on 25/10/23.
//

import SwiftUI

struct EndButton: View {
    @Environment(\.modelContext) var modelContext

    @State private var alertPresented = false

    var currentTrackItem: TrackItem?

    var dismissAction: DismissAction? = nil
    var customAction: (() -> Void)? = nil
    var enforce: Bool = true
    var display: Bool = true

    var body: some View {
        HStack {
            if display {
                Button(role: .none) {
                    if (enforce) {
                        alertPresented = true
                    } else {
                        dismissAction?()
                    }
                } label: {
                    Text("End")
                    .foregroundColor(Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)))
                    .padding(.horizontal, 30)
                    .padding(.bottom, 12.5)
                    .padding(.top, 12.5)
                    .background(Color(#colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)).opacity(0.5))
                    .cornerRadius(26)
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


#Preview {
    EndButton(        currentTrackItem: TrackItem(
        type: TrackItem.TrackType.breathing.rawValue))
}
