//
//  TrackItemView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI
import SwiftData

struct TrackItemView: View {

    var trackItem: TrackItem

    @Query(sort: [SortDescriptor(\TrackItem.endDate)] )
    var trackItems: [TrackItem]

    var previousItem: TrackItem? {
        let _uuid: String = self.trackItem.previousId?.uuidString ?? UUID().uuidString
        var _trackItems: [TrackItem]
        var _trackItem: TrackItem? = nil
        do {
            _trackItems = try trackItems.filter(#Predicate<TrackItem> {$0.id.uuidString == _uuid })
            if _trackItems.count > 0 {
                _trackItem = _trackItems[0]
            }
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
        return _trackItem
    }

    @Environment(\.modelContext) private var modelContext
    @Environment(\.editMode) private var editMode
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        HStack { Spacer() }
                        VStack(alignment: .leading) {
                            Text("Personal Notes")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(trackItem.desc)
                                .fontWeight(.medium)
                        }
                        VStack(alignment: .leading) {
                            Section(
                                header: Text("Previous Exercise")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.init(red: 0.55078125, green: 0.55078125, blue: 0.578125))
                            ) {
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading) {
                                            if previousItem != nil {
                                                NavigationLink {
                                                    TrackItemView(trackItem: previousItem!)
                                                } label: {
                                                    TrackItemRow(trackItem: previousItem!)
                                                }
                                            } else {
                                                Text("No Previous Exercise")
                                            }
                                    }
                                    Spacer()
                                    if previousItem != nil {
                                        Image(systemName: "chevron.right")
                                    }
                                }
                                .padding()
                                .background(.regularMaterial)
                                .cornerRadius(10)
                            }
                        }
                            .padding(.top,16)
                    }
                }
                .safeAreaPadding(.all)
                .navigationTitle(trackItem.type)
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        HStack {
                            Button(action: {
                                trackItem.deleteFrom(modelContext)
                                dismiss()
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItemGroup(placement: .status) {
                        HStack(spacing: 8) {
                            Text(trackItem.startDate.formatted())
                                .font(.caption)
                                .bold()
                            Text(trackItem.endDate?.timeIntervalSince(trackItem.startDate).formatted() ?? "")
                        }
                        .background(.regularMaterial)
                        .cornerRadius(16)
                        .padding(4)
                    }
            }
            }
        }
    }
}

#if DEBUG
#Preview {
    TrackItemView(trackItem: TrackItem())
        .modelContext(ModelContext(try! ModelContainer(for: TrackItem.self)))
}
#endif
