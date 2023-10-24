//
//  TrackHome.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI
import SwiftData

struct TrackHome: View {

    @Environment(ModelData.self) var modelData
    @Environment(\.modelContext) var modelContext
    @Environment(\.editMode) var editMode

    @State private var isAddViewPresented : Bool = false

    @Query(sort: \TrackItem.startDate, order: .reverse)
    var items: [TrackItem]

    private func deleteTrackItem(at indexSet: IndexSet) {
        do {
            for index in indexSet {
                let itemToBeDeleted = items[index]
                modelContext.delete(itemToBeDeleted)
            }
            try modelContext.save()
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
    }

    var body: some View {
        NavigationStack{
            ZStack {
                VStack(spacing: 16) {
                    List {
                        Section(header: Text("History")) {
                            ForEach(items) { trackItem in
                                NavigationLink {
                                    TrackItemView(trackItem: trackItem)
                                } label: {
                                    TrackItemRow(trackItem: trackItem)
                                }
                            }
                            .onDelete(perform: self.deleteTrackItem)
                        }
                    }
                    .listRowSpacing(16)
                    .scrollContentBackground(.hidden)
                    .navigationTitle("Track")
                    .toolbar(.visible, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                    .toolbarBackground(.ultraThinMaterial, for: .tabBar)
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarLeading) {
                            Button(action:{
                                isAddViewPresented = true
                            }) {
                                Label("Add", systemImage: "plus")
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            EditButton()
                        }
                    }
                    .navigationDestination(isPresented: $isAddViewPresented) {
                        TrackItemAddView(isPresented: $isAddViewPresented)
                    }
                }
            }
        }
    }
}


#if DEBUG
#Preview {
    TrackHome()
        .environment(ModelData())
        .modelContext(ModelContext(try! ModelContainer(for: TrackItem.self)))
}
#endif
