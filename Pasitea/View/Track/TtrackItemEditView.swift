//
//  TrackItemAddView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 26/10/23.
//

import SwiftUI
import SwiftData

struct TrackItemEditView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var confirmationRequestPresented: Bool = false

    @State var trackItem: TrackItem

    var body: some View {
        VStack {
            HStack {
                Button(role: .cancel) {
                    confirmationRequestPresented.toggle()
                } label: {
                    Text("Cancel")
                        .bold()
                }.confirmationDialog(
                    "If you made changes, modifications will be cancelled. Do you really want to cancel them?",
                    isPresented: $confirmationRequestPresented) {
                    Button(role: .cancel) {
                        confirmationRequestPresented.toggle()
                    } label: {
                        Text("No")
                    }
                    Button(role: .destructive) {
                        self.dismiss()
                    } label: {
                        Text("Yes")
                    }
                } message: {
                    Text("If you made changes, modifications will be cancelled. Do you really want to cancel them?")
                }
                Spacer()
                Button("Save") {
                    if isFeeling(trackItem) {
                        trackItem.endsAt(trackItem.startDate)
                    }
                    trackItem.saveInto(modelContext)
                    self.dismiss()
                }
            }
            .padding()

            ScrollView(.vertical) {
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        HStack {
                            Label("Typology", systemImage: "square.grid.2x2")

                            Spacer()

                            Picker(selection: $trackItem.typeAsInt, label: Text("Type")) {
                                Text("5 Steps").tag(1)
                                Text("Breathing").tag(2)
                                Text("Listening").tag(3)
                                Text("Feeling").tag(4)
                            }
                            .pickerStyle(.menu)
                            .labelsHidden()
                            .focusable()
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .frame(maxWidth: .infinity)
                                    .background(.regularMaterial)
                                    .opacity(0.1)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    VStack(alignment: .leading) {
                        Label("Personal Notes", systemImage: "face.smiling.inverse")
                        VStack(alignment: .leading) {
                            TextField("I've been feeling blue lately...", text: $trackItem.desc, axis: .vertical)
                                .submitLabel(.next)
                                .lineLimit(10, reservesSpace: true)
                                .labelsHidden()
                                .padding(12)
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(maxWidth: .infinity)
                                .background(.regularMaterial)
                                .opacity(0.1)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                    HStack {
                        VStack(alignment: .leading) {
                            Label(isFeeling(trackItem) ? "Date" : "Start Date", systemImage: "calendar")
                            DatePicker(isFeeling(trackItem) ? "Date" : "Starting Date", selection: $trackItem.startDate)
                                .labelsHidden()
                                .scaledToFill()
                                .focusable()
                        }
                        Spacer()
                    }

                    if !isFeeling(trackItem) {
                        HStack {
                            VStack(alignment: .leading) {
                                Label("End Date", systemImage: "calendar")
                                DatePicker("Ending Date", selection: $trackItem.endDate)
                                    .labelsHidden()
                                    .scaledToFill()
                                    .focusable()
                            }
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .inlineTitle("Editing Tracked Event")
        .navigationBarBackButtonHidden()
        .interactiveDismissDisabled()
        .pasitea()
    }
}

#if DEBUG
struct TrackItemEditView_Preview: PreviewProvider {
    static var previews: some View {
        TrackItemEditView(trackItem: TrackItem())
            .modelContainer(try! ModelContainer(for: TrackItem.self))
    }
}
#endif
