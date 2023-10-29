//
//  CalmBreatheView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmBreatheView: View {
    @Environment(\.dismiss) var dismiss: DismissAction

    @State private var started: Bool = false
    @State private var running: Bool = false

    var trackItem: TrackItem = TrackItem(type: .breathing)

    var body: some View {
        ZStack {
            LightGradientView()

            FlowerAnimationView()

            VStack {
                CustomBackButton(
                    trackItem: trackItem.endsNow(),
                    dismissAction: dismiss,
                    enforce: false,
                    display: .both
                ) {
                    Text("Something")
                }
                Spacer()
            }
        }
        .ultraThinInterface()
    }
}

#if DEBUG
#Preview {
    CalmBreatheView( trackItem: TrackItem() )
}
#endif
