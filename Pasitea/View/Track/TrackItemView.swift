//
//  TrackItemView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI
import SwiftData

struct TrackItemView: View {
    var trackItem: TrackItem

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var isDeletionAlertPresented: Bool = false
    @State private var isEditMode: Bool = false

    @Query(sort: \TrackItem.startDate, order: .reverse)
    var trackItems: [TrackItem]

    var sessionItems: [TrackItem] {
        let selfUuid: String = trackItem.id.uuidString
        let previousId: String = self.trackItem.previousId?.uuidString ?? UUID().uuidString
        let sessionTrackItems: [TrackItem]
        do {
            sessionTrackItems = try trackItems.filter(#Predicate<TrackItem> { item in
                item.id.uuidString == previousId
                    || (item.previousId?.uuidString == previousId && item.id.uuidString != selfUuid)
                    || item.previousId?.uuidString == selfUuid
            })
        } catch {
            sessionTrackItems = []
        }
        return sessionTrackItems
    }

    var body: some View {
        ScrollView {
            HStack {
                Text(trackItem.type)
                    .font(.largeTitle)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .foregroundStyle(.foreground)
                Spacer()
            }
            .padding(.bottom, 16)

            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Personal Notes")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        if trackItem.desc.isEmpty {
                            TrackItemRowEmpty(text: "No notes for this event.")
                        } else {
                            HStack {
                                Text(trackItem.desc)
                                    .fontWeight(.medium)
                                Spacer(minLength: 0)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thinMaterial)
                    .cornerRadius(16)

                    LazyHStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(isFeeling(trackItem) ? "Written on" : "Saved on")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text(trackItem.endDate.formatted())
                                    .fontWeight(.medium)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(16)

                        if !isFeeling(trackItem) {
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Lasted")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Text(
                                        Helper.dateFormatter
                                            .string(from: trackItem.endDate.timeIntervalSince(trackItem.startDate)) ?? "Unknown"
                                    )
                                }
                                Spacer()
                            }
                            .padding()
                            .background(.thinMaterial)
                            .cornerRadius(16)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Section(
                        header: Text("Session Exercises")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    ) {
                        if sessionItems.count > 0 {
                            VStack(alignment: .leading) {
                                ForEach(sessionItems) { item in
                                    NavigationLink {
                                        TrackItemView(trackItem: item)
                                    } label: {
                                        HStack {
                                            TrackItemRow(trackItem: item)
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .accessibilityLabel("See the details")
                                        }
                                        .padding()
                                        .background(.thinMaterial)
                                        .cornerRadius(16)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            TrackItemRowEmpty(
                                text: "No other exercise for this session.",
                                style: .thinMaterial,
                                radius: 16
                            )
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .sheet(isPresented: $isEditMode, content: { TrackItemEditView( trackItem: trackItem ) })
        .padding(.horizontal)
        .padding(.bottom, 16)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Edit", systemImage: "square.and.arrow.down") {
                    isEditMode = true
                }
                .labelStyle(.titleOnly)

                Button {
                    isDeletionAlertPresented.toggle()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .confirmationDialog(
                    Text("You're about to delete this \"\(trackItem.type)\" exercise."),
                    isPresented: $isDeletionAlertPresented
                ) {
                    Button(role: .cancel) {
                        isDeletionAlertPresented.toggle()
                    } label: {
                        Text("Cancel")
                    }
                    Button(role: .destructive) {
                        trackItem.deleteFrom(modelContext)
                        dismiss()
                    } label: {
                        Text("Delete")
                    }
                } message: {
                    Text("You're about to delete this \"\(trackItem.type)\" exercise.")
                }
            }
        }
        .pasitea()
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        TrackItemView(trackItem: TrackItem())
            .modelContext(ModelContext(try! ModelContainer(for: TrackItem.self)))
    }
}
#endif
