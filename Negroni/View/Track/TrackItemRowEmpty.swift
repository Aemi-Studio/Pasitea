//
//  TrackItemRowEmpty.swift
//  Negroni
//
//  Created by Guillaume Coquard on 24/10/23.
//

import SwiftUI

struct TrackItemRowEmpty: View {
    var text: String? = "No previous exercise registered."
    var style = Material.thickMaterial
    var radius: CGFloat? = 8.0

    var body: some View {
        VStack(alignment: .leading) {
            Text(text!)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(style)
        .cornerRadius(radius!)
    }
}

#Preview {
    TrackItemRowEmpty()
}
