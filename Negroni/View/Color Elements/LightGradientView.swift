//
//  LightGradientView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 20/10/23.
//

import SwiftUI

struct LightGradientView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                .accentColor.opacity(0.1),
                .accentColor.opacity(0.3)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
            .edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
#Preview {
    LightGradientView()
}
#endif
