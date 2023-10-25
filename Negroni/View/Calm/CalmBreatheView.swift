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
                
                //BreatheAnimationView()
                FlowerAnimationView( currentTrackItem: TrackItem())
/*
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                    Text("03:00")
                }
 */
            } // Both the Stacks are implemented inside the flowerView
              // to see the other animation remove the comments
              // otherwise you cant go back
            /*
             
            VStack {
                CustomBackButton(
                    currentTrackItem: currentTrackItem,
                    dismissAction: dismiss
                )
                Spacer()
            }
             */
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
