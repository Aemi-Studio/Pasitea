//
//  TrackHome.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct TrackHome: View {

    @Environment(ModelData.self) var modelData

    var body: some View {
        List {
            ForEach(modelData.trackItems) { trackItem in
                TrackItemRow(trackItem: trackItem)
            }
        }
    }
}

#Preview {
    TrackHome()
        .environment(ModelData())
}
