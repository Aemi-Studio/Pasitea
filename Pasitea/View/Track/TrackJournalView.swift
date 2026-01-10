//
//  JournalView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 27/10/23.
//

import SwiftData
import SwiftUI

struct TrackJournalView: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    private var persistence: PersistenceFacade { PersistenceFacade(modelContext: modelContext) }

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
                                            persistence.delete(item)
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
                            let selectionCount = selectedItems.count
                            let maybeEveryText = maybeEvery(selectionCount)
                            let pluralSuffix = plural(selectionCount)
                            let confirmationText =
                                "You're about to remove \(maybeEveryText) saved feeling\(pluralSuffix)."

                            Button(role: .destructive) {
                                deletionConfirmation.toggle()
                            } label: {
                                Label(
                                    !selectedItems.isEmpty
                                        ? "Delete \(selectedItems.count) Feeling\(plural(selectedItems.count))"
                                        : "Delete Everything",
                                    systemImage: "trash.fill"
                                )
                                .labelStyle(.titleOnly)
                                .foregroundStyle(.red)
                                .bold()
                            }
                            .confirmationDialog(
                                confirmationText,

                                isPresented: $deletionConfirmation
                            ) {
                                Button(role: .cancel) {
                                    deletionConfirmation.toggle()
                                } label: {
                                    Text("Cancel")
                                }
                                Button(role: .destructive) {
                                    if !selectedItems.isEmpty {
                                        let itemsToDelete = items.filter { selectedItems.contains($0.id) }
                                        persistence.delete(itemsToDelete)
                                        selectedItems.removeAll()
                                    } else {
                                        persistence.delete(items)
                                    }
                                } label: {
                                    Text("Delete \(maybeEveryText) feeling\(pluralSuffix)")
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
        .modelContainer(_TrackJournalPreview.container)
}

private enum _TrackJournalPreview {
    static let container: ModelContainer = {
        do {
            return try ModelContainer(for: TrackItem.self)
        } catch {
            preconditionFailure(error.localizedDescription)
        }
    }()
}
