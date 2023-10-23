//
//  TrackItemView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct TrackItemView: View {
    
    var trackItem: TrackItem?

    var body: some View {
        VStack(alignment:.leading,spacing: 32) {

            HStack {
                Spacer()
            }

            VStack(alignment: .leading) {
                Text(trackItem!.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text(trackItem!.date.formatted())
                    .font(.caption)
                    .bold()
            }

            VStack(alignment: .leading) {
                Text("Description")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(trackItem!.desc)
            }

            VStack(alignment: .leading) {
                Text("Date")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(trackItem!.date.formatted())
            }

            VStack(alignment: .leading) {
                Text("Type")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(trackItem!.trackType.rawValue)
                    .font(.headline)
                    .fontWeight(.semibold)
            }

            Spacer()
        }
        .padding()
    }
}

#Preview {
    TrackItemView()
}
