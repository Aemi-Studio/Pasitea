//
//  PasiteaHeadlines.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 30/10/23.
//

import SwiftUI

struct PasiteaHeadlines: View {
    var headline: String
    var subheadline: String = ""

    init(_ headline: String, subheadline: String? = "") {
        self.headline = headline
        self.subheadline = subheadline ?? ""
    }

    var body: some View {
        VStack(spacing: 16) {
            Text(headline)
                .pasiteaHeadlineStyle()
            if !subheadline.isEmpty {
                Text(subheadline)
                    .pasiteaSubheadlineStyle()
            }
        }
    }
}

#Preview {
    PasiteaHeadlines("This is an Headline", subheadline: "This is a Subheadline")
}
