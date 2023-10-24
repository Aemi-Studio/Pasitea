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
                Text(trackItem!.type)
                    .bold()
                    .font(.headline)

                Text(trackItem!.startDate.formatted())
                    .font(.caption)

                #if DEBUG
                Text(trackItem!.id.uuidString)
                    .font(.caption)
                #endif

            }
            .padding(4)
    }
}

//#Preview {
//    TrackItemRowBeta(trackItem: nil)
//}
