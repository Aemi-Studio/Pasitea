//
//  TrackItemRowEmpty.swift
//  Negroni
//
//  Created by Guillaume Coquard on 24/10/23.
//

import SwiftUI

struct TrackItemRowEmpty: View {
    var body: some View {
        VStack(alignment: .leading, spacing:8) {
            Text("No previous exercise registered.")
                .bold()
                .font(.headline)
        }
        .padding(4)
    }
}

#Preview {
    TrackItemRowEmpty()
}
