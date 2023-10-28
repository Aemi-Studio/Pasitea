//
//  BigButton.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 19/10/23.
//

import SwiftUI

struct BigButton: View {
    @State private var amount = 0.75
    @State private var blur: CGFloat = 0

    private func rectangleSizeIncrementor(
        _ rectangleSize: CGFloat,
        _ multiplier: CGFloat
    ) -> CGFloat {
        rectangleSize + 28 * multiplier
    }

    var size: CGFloat? = 160
    var title: String?
    var image: Image?
    var color: Color = Color.accentColor

    var body: some View {
        Group {
            if title != nil {
                Text(title!)
            } else if image != nil {
                image!
            } else {
                Text("Hello")
            }
        }
        .font(.system(size: (size! / 11) * 1.5))
        .multilineTextAlignment(.center)
        .kerning(-0.3)
        .fontDesign(.rounded)
        .fontWeight(.bold)
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 20)
        .frame(width: size)
        .background(color)
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .background {
            ZStack {
                BigButtonRectangle(
                    color: color,
                    rectSize: rectangleSizeIncrementor( size!, 1 ),
                    opacityAmount: 1.5,
                    effectAmount: self.amount,
                    effectBlur: self.blur
                )
                .scaledToFill()
                BigButtonRectangle(
                    color: color,
                    rectSize: rectangleSizeIncrementor( size!, 2 ),
                    opacityAmount: 1.25,
                    effectAmount: self.amount,
                    effectBlur: self.blur
                )
                .scaledToFill()
                BigButtonRectangle(
                    color: color,
                    rectSize: rectangleSizeIncrementor( size!, 3 ),
                    opacityAmount: 1.0,
                    effectAmount: self.amount,
                    effectBlur: self.blur
                )
                .scaledToFill()
            }
            .onAppear {
                DispatchQueue.global( qos: .background ).async {
                    withAnimation(
                        .easeOut( duration: 2 )
                            .repeatForever( autoreverses: false )
                    ) {
                        self.amount = 1.5
                    }
                }
                DispatchQueue.global( qos: .background ).async {
                    withAnimation(
                        .timingCurve(0.6, 0, 0.9, 0.5, duration: 2 )
                            .repeatForever( autoreverses: false )
                    ) {
                        self.blur = 20
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    BigButton()
}
#endif
