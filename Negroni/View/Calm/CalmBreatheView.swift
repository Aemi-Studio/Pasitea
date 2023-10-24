//
//  CalmBreatheView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmBreatheView: View {

    @Environment(\.dismiss) var dismiss

    var currentTrackItem: TrackItem

    var body: some View {
        ZStack() {
            
            LightGradientView()
            
            VStack(spacing: 64) {
                
                BigButton(image: Image(systemName: "aqi.medium"))
                
                Text("Breathe")
                    .font(.title)
                    .bold()
                
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                    Text("03:00")
                }
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            }
            
            VStack {
                CustomBackButton(
                    currentTrackItem: currentTrackItem,
                    dismissAction: dismiss
                )
                Spacer()
            }
            .toolbar(.hidden, for: .tabBar)
            .toolbarBackground(.hidden, for: .tabBar)
        }
    }
}
 

#if DEBUG
#Preview {
    CalmBreatheView(
        currentTrackItem: TrackItem()
    )
}
#endif
