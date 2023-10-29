//
//  CustomProgressStyle.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 29/10/23.
//

import SwiftUI

struct CustomProgressStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geo in
            let loadedWidth = CGFloat(configuration.fractionCompleted ?? 0) * geo.size.width
            let remainingWidth = geo.size.width - CGFloat(configuration.fractionCompleted ?? 0) * geo.size.width

            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.accent)
                    .frame(width: loadedWidth)

                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        configuration.label
                            .foregroundStyle(.white)
                    }
                    .frame(height: geo.size.height)
                }
                .frame(width: geo.size.width)
                .clipShape(Rectangle()
                            .path(in: CGRect(
                                x: 0,
                                y: 0,
                                width: loadedWidth,
                                height: geo.size.height
                            ))
                )

                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        configuration.label
                            .foregroundStyle(.accent)
                    }
                    .frame(height: geo.size.height)
                }
                .frame(width: geo.size.width)
                .clipShape(Rectangle()
                            .path(in: CGRect(
                                x: loadedWidth,
                                y: 0,
                                width: remainingWidth,
                                height: geo.size.height
                            ))
                )
            }
        }
    }
}
