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

    @State private var isAddViewPresented : Bool = false

    @Query(sort: \TrackItem.date, order: .reverse)
    var trackItems: [TrackItem]


    var body: some View {
        NavigationStack {
            List {
                ForEach(trackItems) { trackItem in
                    TrackItemRow(trackItem: trackItem)
                }
            }
            .sheet(isPresented: $isAddViewPresented) {
                TrackItemAddView()
            }
            .toolbar {
                Button(action:{
                    isAddViewPresented = true
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
    }
}

#Preview {
    TrackHomeBeta()
        .environment(ModelData())
}
