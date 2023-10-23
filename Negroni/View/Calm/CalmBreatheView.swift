//
//  CalmBreatheView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmBreatheView: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack() {
            
            LightGradientView()
                .edgesIgnoringSafeArea(.all)
            
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
                CustomBackButton(dismissAction: dismiss)
                Spacer()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}
        
        #Preview {
            CalmBreatheView()
        }
