//
//  AudioPlayer.swift
//  Negroni
//
//  Created by Antonio Abbatiello on 26/10/23.
//

import SwiftUI
import AVKit

struct AudioPlayer: View {
    @State private var audioPlayer: AVAudioPlayer!
    @State private var moveBars = false
    @State private var transparency = 0.0
    
    
    
    var animation: Animation {
        return (moveBars ? .linear(duration: 0.5).repeatForever() : .linear(duration: 0.5))
    }
    
    
    var body: some View {
        VStack {
            
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        bar(low: 0.3)
                            .animation(animation.speed(1.5), value: moveBars)
                        bar(low: 0.3)
                            .animation(animation.speed(1.2), value: moveBars)
                        bar(low: 0.3)
                            .animation(animation.speed(1.0), value: moveBars)
                        bar(low: 0.3)
                            .animation(animation.speed(1.7), value: moveBars)
                        bar(low: 0.3)
                            .animation(animation.speed(1.1), value: moveBars)
                    }
                    .frame(width: 80)
                    .onAppear{
                        moveBars = true
                        self.audioPlayer.numberOfLoops = -1 // loops forever
                        self.audioPlayer.play()
                    }
                    .onDisappear {
                        moveBars = false
                        self.audioPlayer.pause()
                    }
                }
            }
            
            
        }
        
        HStack {
            Button {
                if(moveBars) {
                    self.audioPlayer.pause()
                } else {
                    self.audioPlayer.play()
                }
                moveBars.toggle()
                withAnimation(.easeOut(duration: 0.2)) {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        transparency = 0.0
                    }
                }
            } label: {
                ZStack {
                    Image(systemName: "play.fill").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(moveBars ? 0 : 1)
                        .opacity(moveBars ? 0 : 1)
                        .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: moveBars)
                    Image(systemName: "pause.fill").resizable()
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                        .scaleEffect(moveBars ? 1 : 0)
                        .opacity(moveBars ? 1 : 0)
                        .animation(.interpolatingSpring(stiffness: 170, damping: 15), value: moveBars)
                }
                
            }

        }
        
        .onAppear {
            let sound = Bundle.main.path(forResource: "water", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
        
    }
    
    func bar(low: CGFloat = -1.0, high: CGFloat = 1.0) -> some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(.blue.gradient)
            .frame(height: (moveBars ? high*64 : low*32))
            .frame(height: 64, alignment: .center)
    }
}


#Preview {
    AudioPlayer()
}
