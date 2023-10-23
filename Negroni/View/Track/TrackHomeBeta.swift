//
//  TrackHome.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI
import SwiftData

struct TrackHomeBeta: View {

    @Environment(ModelData.self) var modelData
    @Environment(\.modelContext) var modelContext
    @Environment(\.editMode) var editMode

    @State private var isAddViewPresented : Bool = false

    @Query(sort: \TrackItem.date, order: .reverse)
    var trackItems: [TrackItem]


    private func deleteTrackItem(at indexSet: IndexSet) {
        do {
            for index in indexSet {
                let itemToBeDeleted = trackItems[index]
                modelContext.delete(itemToBeDeleted)
            }
            try modelContext.save()
        } catch {
            print("I shat somewhere.")
        }
    }


    var body: some View {


        NavigationStack {
            VStack {
                List {
                    ForEach(trackItems) { trackItem in
                        NavigationLink {
                            TrackItemView(trackItem: trackItem)
                        } label: {
                            TrackItemRow(trackItem: trackItem)
                        }
                    }
                    .onDelete(perform: self.deleteTrackItem)
                }
                .listRowSpacing(16)
                .listStyle(.insetGrouped)
                .navigationTitle("History")
                .sheet(isPresented: $isAddViewPresented) {
                    TrackItemAddView()
                }
            }.toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action:{
                        isAddViewPresented = true
                    }) {
                        Label("Add", systemImage: "square.and.pencil")
                    }
                }
            }
        }
    }
}

#Preview {
    TrackHomeBeta()
        .environment(ModelData())
        .modelContext(ModelContext(try! ModelContainer(for: TrackItem.self)))
}
