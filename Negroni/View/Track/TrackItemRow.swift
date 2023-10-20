//
//  TrackItemRow.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI
import SwiftData

struct TrackItemRow: View {

    var trackItem: TrackItem?

    var body: some View {
        VStack(alignment: .leading, spacing:5) {
            Text(((trackItem?.title.isEmpty) != nil) ? "Lorem Ipsum" : trackItem!.title)
            Text(trackItem!.date.formatted())
                .font(.caption)
        }
    }
}

//#Preview {
//    TrackItemRowBeta(trackItem: nil)
//}
