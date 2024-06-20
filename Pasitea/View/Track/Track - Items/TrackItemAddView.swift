//
//  TrackItemAddView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 20/10/23.
//

import SwiftUI
import SwiftData

struct TrackItemAddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss: DismissAction

    @State private var desc: String = ""
    @State private var trackTypeId: Int = 4
    @State private var startDate: Date = Date.now
    @State private var endDate: Date = Date.now

    @State private var confirmationRequestPresented: Bool = false

    @FocusState var isTextFieldFocused: Bool

    var previousId: UUID?

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
                    TrackItem(
                        type: TrackType.allCases[trackTypeId],
                        desc: desc,
                        startDate: startDate,
                        endDate: endDate,
                        previousId: previousId
                    ).saveInto(modelContext, endDate)
                    self.dismiss()
                }.disabled(desc.isEmpty)
            }
            .padding()

            ScrollView(.vertical) {
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        HStack {
                            Label("Typology", systemImage: "square.grid.2x2")

                            Spacer()

                            HStack {
                                Picker(selection: $trackTypeId, label: Text("Typology")) {
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
                    }

                    VStack(alignment: .leading) {
                        Label("Personal Notes", systemImage: "face.smiling.inverse")
                        VStack {
                            VStack(alignment: .leading) {
                                TextField("I've been feeling blue lately...", text: $desc, axis: .vertical)
                                    .focused($isTextFieldFocused)
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
                            .onTapGesture {
                                isTextFieldFocused = true
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    if trackTypeId != 4 {
                        HStack {
                            VStack(alignment: .leading) {
                                Label("Start Date", systemImage: "calendar")
                                DatePicker("Starting Date\n", selection: $startDate)
                                    .labelsHidden()
                                    .scaledToFill()
                                    .focusable()
                            }
                            Spacer()
                        }

                        HStack {
                            VStack(alignment: .leading) {
                                Label("End Date", systemImage: "calendar")
                                DatePicker("Ending Date\n", selection: $endDate)
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
        .inlineTitle("New Tracked Event")
        .navigationBarBackButtonHidden()
        .interactiveDismissDisabled()
        .pasitea()
        .onTapGesture {
            isTextFieldFocused = false
        }
    }
}

#if DEBUG
struct TrackItemAddView_Preview: PreviewProvider {
    static var previews: some View {
        @State var isPresented = true

        TrackItemAddView()
            .modelContainer(try! ModelContainer(for: TrackItem.self))
    }
}
#endif
