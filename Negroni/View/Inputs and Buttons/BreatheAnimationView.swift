//
//  BreatheAnimationView.swift
//  Negroni
//
//  Created by Antonio Abbatiello on 24/10/23.
//

import SwiftUI

struct BreatheAnimationView: View {
    @State public var enableBreathIn = true
    @State public var enableBreathOut = false
    @State var rotate = false
    
    
    var body: some View {
        VStack(spacing: 96) {
            ZStack {
                //AnimationV1()
                //AnimationOld()
                AnimationV2()

                    
                
                    
            }
            
            Text("Breathe In..")
                .opacity(enableBreathIn ? 0 : 1)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .onAppear {
                    withAnimation(Animation.default.delay(34.2).repeatForever(autoreverses: true).speed(10)) {
                        enableBreathIn.toggle()
                        
                    }
                   
                }
            Text("Breathe Out..")
                .opacity(enableBreathOut ? 0 : 1)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .offset(y: -130)
                .bold()
                .onAppear {
                    withAnimation(Animation.default.delay(34.2)
                        .repeatForever(autoreverses: true).speed(10)) {
                        enableBreathOut.toggle()
                        
                    }
                   
                }
                
            }
                
        }
                
}


#Preview {
    BreatheAnimationView()
}



struct BreatheAnimationDefault: View {
    @State  var isCenter = true
    @State  var isCenter2 = true
    @State  var duration = 4.0
    
    
    var body: some View {
        ZStack {
            Circle()
                .frame (width: 100, height: 100)
                .foregroundColor(Color.blue.opacity(0.5))
                .offset(x: isCenter ? 0 : 50)
                .rotationEffect (Angle(degrees: isCenter2 ? 0: 360))
            Circle()
                .frame (width: 100, height: 100)
                .foregroundColor(Color.blue.opacity(0.5))
                .offset(x: isCenter ? 0 : -50)
                .rotationEffect (Angle (degrees: isCenter2 ? 0: 360))
            Circle()
                .frame (width: 100, height: 100)
                .foregroundColor (Color.blue.opacity(0.5))
                .offset(y: isCenter ? 0 : 50)
                .rotationEffect(Angle (degrees: isCenter2 ? 0: 360))
            Circle()
                .frame (width: 100, height: 100)
                .foregroundColor(Color.blue.opacity(0.5))
                .offset(y: isCenter ? 0 : -50)
                .rotationEffect(Angle (degrees: isCenter2 ? 0: 360))
        }
        .onAppear() {
            let animation = Animation.linear(duration: duration)
            
            withAnimation(animation.repeatForever(autoreverses: true)) {
                self.isCenter = false
            }
            
            withAnimation(animation.repeatForever(autoreverses: true)) {
                self.isCenter2 = false
            }
            
        }
    }

}


struct AnimationV1: View {
    @State  var isCenter = true
    @State  var isCenter2 = true
    @State  var duration = 5.0
    
    
    var body: some View {
        ZStack {
            Circle()
                .frame (width: 100, height: 100)
                .foregroundColor(Color.blue.opacity(0.5))
                .offset(x: isCenter ? 0 : 50)
                .rotationEffect (Angle(degrees: isCenter2 ? 0: 360))
            Circle()
                .frame (width: 100, height: 100)
                .foregroundColor(Color.blue.opacity(0.5))
                .offset(x: isCenter ? 0 : -50)
                .rotationEffect (Angle (degrees: isCenter2 ? 0: 360))
            Circle()
                .frame (width: 100, height: 100)
                .foregroundColor (Color.blue.opacity(0.5))
                .offset(y: isCenter ? 0 : 50)
                .rotationEffect(Angle (degrees: isCenter2 ? 0: 360))
            Circle()
                .frame (width: 100, height: 100)
                .foregroundColor(Color.blue.opacity(0.5))
                .offset(y: isCenter ? 0 : -50)
                .rotationEffect(Angle (degrees: isCenter2 ? 0: 360))
        }
        .onAppear() {
            let animation = Animation.linear(duration: duration)
            
            withAnimation(animation.repeatForever(autoreverses: true)) {
                self.isCenter = false
            }
            
            withAnimation(animation.repeatForever(autoreverses: false)) {
                self.isCenter2 = false
            }
            
        }
        
    }

}

struct AnimationOld: View {
    @State  var isCenter = true
    @State  var isCenter2 = true
    @State  var duration = 5.0
    
    
    var body: some View {
        ZStack {
            Circle()
                .frame (width: 150, height: 150)
                .foregroundColor(Color.blue.opacity(0.5))
                .offset(x: isCenter ? 50 : 0)
                .rotationEffect (Angle(degrees: isCenter2 ? 360: 0))
            Circle()
                .frame (width: 150, height: 150)
                .foregroundColor(Color.blue.opacity(0.5))
                .offset(x: isCenter ? -50 : 0)
                .rotationEffect (Angle (degrees: isCenter2 ? 360: 0))
            Circle()
                .frame (width: 150, height: 150)
                .foregroundColor (Color.blue.opacity(0.5))
                .offset(y: isCenter ? 50 : 0)
                .rotationEffect(Angle (degrees: isCenter2 ? 360: 0))
            Circle()
                .frame (width: 150, height: 150)
                .foregroundColor(Color.blue.opacity(0.5))
                .offset(y: isCenter ? -50 : 0)
                .rotationEffect(Angle (degrees: isCenter2 ? 360: 0))
            Circle().fill(LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom))
                .frame(width: 150, height: 150)
                .offset(y: isCenter ? 50 : 0)
        }
        .onAppear() {
            let animation = Animation.linear(duration: duration)
            
            withAnimation(animation.repeatForever(autoreverses: true)) {
                self.isCenter = false
            }
            
            withAnimation(animation.repeatForever(autoreverses: true)) {
                self.isCenter2 = false
            }
            
        }
    }

}


struct AnimationV2: View {

    @State var startAnimation = true
    @State var rotationValue = false

    var body: some View {
        ZStack {
            ForEach((0...2), id: \.self) {circleSetNumber in
                ZStack {
                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 150, height: 150)
                        .offset(y: startAnimation ? 75 : 0)

                    Circle().fill(LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .bottom, endPoint: .top))
                        .frame(width: 150, height: 150)
                        .offset(y: startAnimation ? -75 : 0)
                }
                .opacity(0.5)
                .rotationEffect(.degrees(startAnimation ? Double(circleSetNumber*60) : 0))
                .scaleEffect(startAnimation ? 1 : 0.1)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3.5).repeatForever(autoreverses: true)) {
                         startAnimation.toggle()
                    }

                 }
            }
        }
    }
}
