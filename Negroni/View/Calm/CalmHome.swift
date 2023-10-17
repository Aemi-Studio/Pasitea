//
//  CalmHome.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct CalmHome: View {

    @State private var isPresented = false

    func something() {
    }

    var cs: CGFloat = 160
    func iCS(_ cs: CGFloat,_ multiplier: CGFloat) -> CGFloat {
        return cs + 28 * multiplier
    }

    var body: some View {

        NavigationStack {
            
            VStack(spacing: 96) {

                NavigationLink(destination: CalmDynamicView()) {
                    Text("Calm\nDown")
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


                HStack(spacing: 32) {

                    NavigationLink(destination: CalmBreatheView()) {
                        Text("Breathe")
                            .padding([.top,.bottom], 10)
                            .padding([.leading,.trailing], 20)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: CalmListenView()) {
                        Text("Listen")
                            .padding([.top,.bottom], 10)
                            .padding([.leading,.trailing], 20)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    }

                }

            }

        }

    }
}

#Preview {
    CalmHome()
}
