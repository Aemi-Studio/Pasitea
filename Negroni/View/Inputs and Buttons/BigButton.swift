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
    @State var amount = 0.75
    
    var title: String?
    var image: Image?
    var color: Color? = Color.blue
    
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
        .frame(width:cs,height:cs)
        .background(color)
        .foregroundColor(Color.white)
        .cornerRadius(.infinity)
        .background {
            ZStack {
                Circle()
                    .frame(width:iCS(cs,1),height:iCS(cs,1))
                    .foregroundColor(color)
                    .opacity(1.5 - amount)
                    .scaleEffect(amount)
                    .onAppear {
                        DispatchQueue.global(qos: .background).async {
                            withAnimation(.easeOut(duration: 2) .repeatForever(autoreverses: false))
                            {
                                self.amount = 1.5
                            }
                        }
                    }
                Circle()
                    .frame(width:iCS(cs,2),height:iCS(cs,2))
                    .foregroundColor(color)
                    .opacity(1.25 - amount)
                    .scaleEffect(amount)
                    .onAppear {
                        DispatchQueue.global(qos: .background).async {
                            withAnimation(.easeOut(duration: 2) .repeatForever(autoreverses: false))
                            {
                                self.amount = 1.5
                            }
                        }
                    }
                Circle()
                    .frame(width:iCS(cs,3),height:iCS(cs,3))
                    .foregroundColor(color)
                    .opacity(1.0 - amount)
                    .scaleEffect(amount)
                    .onAppear {
                        DispatchQueue.global(qos: .background).async {
                            withAnimation(.easeOut(duration: 2) .repeatForever(autoreverses: false))
                            {
                                self.amount = 1.5
                            }
                        }
                    }
                
            }
        }
        
    }
    
    
}

#Preview {
    BigButton()
}
