//
//  CustomBackButton.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 18/10/23.
//

import SwiftUI

struct CustomBackButton<Content: View>: View {
    @Environment(\.modelContext) var modelContext

    @State private var infoPresented = false
    @State private var alertPresented = false
    @State private var isButtonPressed = false

    var trackItem: TrackItem?

    var dismissAction: DismissAction?
    var customAction: (() -> Void)?
    var customDismiss: CustomDismiss?

    var enforce: Bool = true
    var display: TopBarIconSet = .close

    @ViewBuilder var content: Content

    var body: some View {
        HStack {
            if display.isSubset(of: .both) {
                if display.contains(.info) {
                    Button {
                        isButtonPressed.toggle()
                        infoPresented = true
                    } label: {
                        Label("Informations", systemImage: "info.circle")
                            .customSingleBackButton()
                    }
                    .sheet(isPresented: $infoPresented) {
                        content
                    }
                }
                Spacer()
                if display.contains(.close) {
                    Button(role: .none) {
                        isButtonPressed.toggle()
                        if enforce {
                            alertPresented = true
                        } else {
                            trackItem?.saveInto(modelContext)
                            withAnimation {
                                dismissAction?()
                                customAction?()
                                customDismiss?()
                            }
                        }
                    } label: {
                        Label("Close", systemImage: "xmark.circle.fill")
                            .customSingleBackButton()
                    }
                }
            } else if display.contains(.add) {
                Button {
                    isButtonPressed.toggle()
                    infoPresented = true
                } label: {
                    Label("Add", systemImage: "plus.circle")
                        .customSingleBackButton()
                }
                .sheet(isPresented: $infoPresented) {
                    content
                }
            } else {
                EmptyView()
                    .frame(height: 48)
            }
        }
        .customHaptic(isButtonPressed)
        .confirmationDialog(
            "You're about to exit an ongoing exercise. Are you sure about it?",
            isPresented: $alertPresented
        ) {
            Button(role: .destructive) {
                // Save the exercise
                trackItem?.saveInto(modelContext)
                withAnimation {
                    dismissAction?()
                    customAction?()
                    customDismiss?()
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
