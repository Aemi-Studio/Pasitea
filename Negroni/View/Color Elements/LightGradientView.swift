//
//  LightGradientView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 20/10/23.
//

import SwiftUI

struct LightGradientView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    .customBackground.opacity(0.6),
                    .customBackground.opacity(0.1)
                ]),
                startPoint: .bottom,
                endPoint: .top
            )
            .ignoresSafeArea(.all)

            Color.customBackground
                .ignoresSafeArea(.all)
        }
    }
}

#if DEBUG
#Preview {
    LightGradientView()
}
#endif
