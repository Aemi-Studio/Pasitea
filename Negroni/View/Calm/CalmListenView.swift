//
//  CalmListenView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmListenView: View {

    @Environment(\.dismiss) var dismiss

    var trackItem: TrackItem = TrackItem(type:.listening)

    var body: some View {
        ZStack {
            
            LightGradientView()

            VStack(spacing: 64) {
                AudioPlayer()
                Text("Listen to this sound")
                    .font(.title)
                    .bold()
            }
            
            VStack {
                CustomBackButton( trackItem: trackItem, dismissAction: dismiss )
                Spacer()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbarBackground(.hidden, for: .tabBar)
    }
}

#if DEBUG
#Preview {
    CalmListenView( trackItem: TrackItem() )
}
#endif

