//
//  TrackItemRow.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI
import SwiftData

struct TrackItemRow: View {
    var trackItem: TrackItem
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(trackItem.type)
                    .bold()
                    .font(.headline)

                Text(trackItem.startDate.formatted())
                    .font(.caption)
            }
        }
    }
}

#if DEBUG
#Preview {
    TrackItemRow(trackItem: TrackItem())
}
#endif
