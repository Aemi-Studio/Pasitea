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
        VStack(alignment: .leading, spacing:8) {
            Text(trackItem!.title)
                .bold()
                .font(.headline)

            Text(trackItem!.date.formatted())
                .font(.caption)
        }
        .padding(4)
    }
}

//#Preview {
//    TrackItemRowBeta(trackItem: nil)
//}
