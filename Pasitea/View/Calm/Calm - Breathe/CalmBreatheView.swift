//
//  CalmBreatheView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI
import SwiftData

struct CalmBreatheView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @Environment(\.modelContext) var modelContext

    @State private var started: Bool = false
    @State private var running: Bool = false

    var trackItem: TrackItem = TrackItem(type: .breathing)

    var item: TrackItemWrapper { TrackItemWrapper( trackItem ) }

    var body: some View {
        ZStack {
            GradientView()

            BreatheFlowerAnimation(started: $started, trackItem: item)

            VStack {
                CustomBackButton(
                    dismissAction: dismiss,
                    enforce: false,
                    display: .both
                ) {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Breathe")
                            .font(.title2)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                        Group {
                            Text("""
Cardiac coherence is a breathing technique designed to synchronize your breath with your heart rate for improved emotional well-being and stress reduction.

It involves slow, rhythmic breathing, typically at a rate of around six breaths per minute, which helps balance the autonomic nervous system.

By practicing cardiac coherence, you can enhance your ability to manage stress and enhance your overall sense of well-being.
""")
                        }
                        .multilineTextAlignment(.leading)
                        .fontWeight(.medium)
                    }
                    .padding()
                    .informationModalStyle()
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
