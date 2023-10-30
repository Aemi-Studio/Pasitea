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
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Breathe")
                            .font(.title2)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                        Group {
                            Text("""
This specific breathing exercise is based on Cardiac Coherence which a relies on the 3-6-5 method.

This method consists in practicing 3 times a day, 6 breathing per minutes for 5 minutes.

The button which act also as a progress bar indicates your current progress for the exercise.
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
