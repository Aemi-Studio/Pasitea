//
//  BigButton.swift
//  Negroni
//
//  Created by Guillaume Coquard on 19/10/23.
//

import SwiftUI

var cs: CGFloat = 160
func iCS(_ cs: CGFloat,_ multiplier: CGFloat) -> CGFloat {
    return cs + 28 * multiplier
}

struct BigButton: View {
    var body: some View {
        Text("Calm Down")
            .font(.title)
            .multilineTextAlignment(.center)
            .kerning(-0.3)
            .fontDesign(.rounded)
            .fontWeight(.bold)
            .padding([.top,.bottom], 10)
            .padding([.leading,.trailing], 20)
            .frame(width:cs,height:cs)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(.infinity)
            .background {
                ZStack {
                    Circle()
                        .frame(width:iCS(cs,1),height:iCS(cs,1))
                        .opacity(0.25)
                    Circle()
                        .frame(width:iCS(cs,2),height:iCS(cs,2))
                        .opacity(0.25)
                    Circle()
                        .frame(width:iCS(cs,3),height:iCS(cs,3))
                        .opacity(0.25)
                }
            }

    }
}

#Preview {
    BigButton()
}
