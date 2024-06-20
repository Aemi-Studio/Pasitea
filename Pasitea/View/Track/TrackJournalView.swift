//
//  JournalView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 27/10/23.
//

import SwiftUI
import SwiftData

struct TrackJournalView: View {
    @Environment(\.modelContext) var modelContext

    @State private var editMode: EditMode = EditMode.inactive
    @State private var deletionConfirmation: Bool = false
    @State private var selectedItems: Set<UUID> = Set<UUID>()

    var items: [TrackItem]

    var body: some View {
        VStack {
            if items.isEmpty {
                VStack {
                    Text("It looks like there's nothing here").multilineTextAlignment(.center).opacity(0.5)
                }
            } else {
                List(selection: $selectedItems) {
                    Section {
                        ForEach(items) { item in
                            NavigationLink {
                                TrackItemView(trackItem: item)
                            } label: {
                                TrackItemRow(trackItem: item)
                                    .swipeActions(edge: .trailing) {
                                        Button("Delete", systemImage: "trash", role: .destructive) {
                                            item.deleteFrom(modelContext)
                                        }
                                    }
                            }
                        }
                    } header: {
                        Text("Journal")
                            .sectionToLargeTitle()
                    }
                }
                .customListStyle()
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        if $editMode.wrappedValue == .active {
                            Button(role: .destructive) {
                                deletionConfirmation.toggle()
                            } label: {
                                Label( !selectedItems.isEmpty
                                        ? "Delete \(selectedItems.count) Feeling\(plural(selectedItems.count))"
                                        : "Delete Everything",
                                       systemImage: "trash.fill")
                                    .labelStyle(.titleOnly)
                                    .foregroundStyle(.red)
                                    .bold()
                            }
                            .confirmationDialog(
                                "You're about to remove \(maybeEvery(selectedItems.count)) saved feeling\(plural(selectedItems.count)).",

                                isPresented: $deletionConfirmation
                            ) {
                                Button(role: .cancel) {
                                    deletionConfirmation.toggle()
                                } label: {
                                    Text("Cancel")
                                }
                                Button(role: .destructive) {
                                    if !selectedItems.isEmpty {
                                        selectedItems.forEach { id in
                                            items.first { item in
                                                id == item.id
                                            }?.deleteFrom(modelContext)
                                            selectedItems.remove(id)
                                        }
                                    } else {
                                        items.forEach { item in
                                            item.deleteFrom(modelContext)
                                        }
                                    }
                                } label: {
                                    Text(" Delete \(maybeEvery(selectedItems.count)) feeling\(plural(selectedItems.count))")
                                }
                            }
                            .disabled(items.isEmpty)
                        }
                    }
                }
                .environment(\.editMode, $editMode)
            }
        }
        .pasitea()
    }
}

#Preview {
    TrackJournalView(items: [TrackItem()])
        .modelContainer( try! ModelContainer(for: TrackItem.self ))
}
