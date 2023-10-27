//
//  FlowerAnimationView.swift
//  Negroni
//
//  Created by Antonio Abbatiello on 25/10/23.
//

import SwiftUI

struct FlowerAnimationView: View {
    @State private var rBreath = false
    @State private var lBreath = false
    @State private var mrBreath = false
    @State private var mlBreath = false
    @State private var showShadow = false
    @State private var showRightStroke = false
    @State private var showLeftStroke = false
    @State private var showInhale = true
    @State private var showExhale = false
    @Environment(\.dismiss) var dismiss

    var currentTrackItem: TrackItem
    
    var body: some View {
        
            ZStack {
                    Text("Breath In")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .opacity(showInhale ? 0 : 1)
                        .scaleEffect(showInhale ? 0 : 1, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .offset(y: -200)
                        .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                        .onAppear {
                            showInhale.toggle()
                        }
                    
                    Text("Breath Out")
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)))
                        .font(.largeTitle)
                        .opacity(showExhale ? 0 : 1)
                        .offset(y: -200)
                        .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                        .onAppear {
                            showExhale.toggle()
                        }
                HStack(spacing: 8) {
                    Image(systemName: "clock")
                        .offset(y: 200)
                    Text("03:00")
                        .offset(y: 200)
                }
            
                
                EndButton(
                    currentTrackItem: currentTrackItem,
                    dismissAction: dismiss
                )
                    .offset(y: 300)
                
                    ZStack {
                        Image("flower")  // Middle
                            .rotationEffect(.degrees(0), anchor: .bottom)
                        
                        Image("flower")  // Middle left
                        Image("flower")  // Left
                            .rotationEffect(.degrees( mlBreath ? -25 : -5), anchor: .bottom)
                            .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                            .onAppear {
                                mlBreath.toggle()
                            }
                        
                        Image("flower")  // Middle right
                        Image("flower")  // Right
                            .rotationEffect(.degrees( mrBreath ? 25 : 5), anchor: .bottom)
                            .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                            .onAppear {
                                mrBreath.toggle()
                            }
                        Image("flower")  // Left
                            .rotationEffect(.degrees( lBreath ? -50 : -10), anchor: .bottom)
                            .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                            .onAppear {
                                lBreath.toggle()
                            }
                        
                        Image("flower")  // Right
                            .rotationEffect(.degrees( rBreath ? 50 : 10), anchor: .bottom)
                            .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                            .onAppear {
                                rBreath.toggle()
                            }
                        
                    }.shadow(radius: showShadow ? 20 : 0)
                        .hueRotation(Angle(degrees: showShadow ? -170 : 0))
                        .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                        .onAppear {
                            showShadow.toggle()
                        }
                    Circle()  // Left Stroke
                        .trim(from: showLeftStroke ? 0 : 1/4, to: 1/4)
                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [7, 14]))
                        .frame(width: 215, height: 215, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .rotationEffect(.degrees(-180), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .offset(x: 0, y: -25)
                        .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                        .onAppear {
                            showLeftStroke.toggle()
                        }
                    
                    Circle()  // Right stroke
                        .trim(from: 0, to: showRightStroke ? 1/4 : 0)
                        .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, dash: [7, 14]))
                        .frame(width: 215, height: 2215, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .rotationEffect(.degrees(-90), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .offset(x: 0, y: -25)
                        .animation(Animation.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true))
                        .onAppear {
                            showRightStroke.toggle()
                        }
                }
            }
    }
    
    


#Preview {
    FlowerAnimationView( currentTrackItem: TrackItem())
}
