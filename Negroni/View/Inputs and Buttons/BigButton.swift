//
//  BigButton.swift
//  Negroni
//
//  Created by Guillaume Coquard on 19/10/23.
//

import SwiftUI

struct BigButton: View {

    @State private var amount = 0.75

    private let circleSize: CGFloat = 160

    private func circleSizeIncrementor(
        _ circleSize: CGFloat,
        _ multiplier: CGFloat
    ) -> CGFloat {
        circleSize + 28 * multiplier
    }

    var title: String?
    var image: Image?
    var color: Color? = Color.accentColor

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
        .font(.title)
        .multilineTextAlignment(.center)
        .kerning(-0.3)
        .fontDesign(.rounded)
        .fontWeight(.bold)
        .padding([.top,.bottom], 10)
        .padding([.leading,.trailing], 20)
        .frame(width:circleSize,height:circleSize)
        .background(color)
        .foregroundColor(Color.white)
        .cornerRadius(.infinity)
        .background {
            ZStack {
                Circle()
                    .frame(
                        width: circleSizeIncrementor( circleSize, 1 ),
                        height: circleSizeIncrementor( circleSize, 1 )
                    )
                    .foregroundColor(color)
                    .opacity(1.5 - amount)
                    .scaleEffect(amount)
                    .onAppear {
                        DispatchQueue.global( qos: .background ).async {
                            withAnimation(
                                .easeOut( duration: 2 )
                                .repeatForever( autoreverses: false )
                            ) {
                                self.amount = 1.5
                            }
                        }
                    }
                Circle()
                    .frame(
                        width: circleSizeIncrementor( circleSize, 2 ),
                        height: circleSizeIncrementor( circleSize, 2 )
                    )
                    .foregroundColor(color)
                    .opacity(1.25 - amount)
                    .scaleEffect(amount)
                    .onAppear {
                        DispatchQueue.global( qos: .background ).async {
                            withAnimation(
                                .easeOut( duration: 2 )
                                .repeatForever( autoreverses: false )
                            ) {
                                self.amount = 1.5
                            }
                        }
                    }
                Circle()
                    .frame(
                        width: circleSizeIncrementor( circleSize, 3 ),
                        height: circleSizeIncrementor( circleSize, 3 )
                    )
                    .foregroundColor(color)
                    .opacity(1.0 - amount)
                    .scaleEffect(amount)
                    .onAppear {
                        DispatchQueue.global( qos: .background ).async {
                            withAnimation(
                                .easeOut( duration: 2 )
                                .repeatForever( autoreverses: false )
                            ) {
                                self.amount = 1.5
                            }
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
