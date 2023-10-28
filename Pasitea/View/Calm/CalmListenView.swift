//
//  CalmListenView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI
import AVKit

struct CalmListenView: View {
    @Environment(\.dismiss) var dismiss

    @State private var audioPlayer: AVAudioPlayer!
    @State private var moveBars = false
    @State private var transparency = 0.0
    @State private var alreadyPlayed = false

    var trackItem: TrackItem = TrackItem(type: .listening)

    var animation: Animation {
        moveBars
            ? .timingCurve(0.3, 0, 0.8, 1, duration: 0.5).repeatForever()
            : .timingCurve(0.3, 0, 0.8, 1, duration: 0.5)
    }

    private func bar(low: CGFloat = -1.0, high: CGFloat = 1.0) -> some View {
        UnevenRoundedRectangle(cornerRadii: .init(
            topLeading: 20,
            bottomLeading: 20,
            bottomTrailing: 20,
            topTrailing: 20
        ), style: .continuous)
        .fill(.customBackground)
        .frame(height: (moveBars ? high * 64 : low * 32))
        .frame(height: 64, alignment: .center)
    }

    var body: some View {
        ZStack {
            LightGradientView()

            VStack(spacing: 48) {
                VStack {
                    VStack {
                        VStack(alignment: .center) {
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
                            .frame(width: 80, height: 80)
                            .onDisappear {
                                moveBars = false
                                self.audioPlayer.stop()
                            }
                        }
                        .padding(.all, 32)
                        .background(Color.accentColor)
                        .clipShape(.circle)
                    }
                }

                Text("Listen to this sound")
                    .font(.title)
                    .fontDesign(.serif)
                    .bold()
                    .frame(height: 64)

                HStack {
                    Button(
                        moveBars ? "Pause" : alreadyPlayed ? "Resume" : "Start",
                        systemImage: moveBars ? "pause" : alreadyPlayed ? "arrow.clockwise" : "play"
                    ) {
                        if !alreadyPlayed {
                            alreadyPlayed = true
                        }
                        if moveBars {
                            self.audioPlayer.pause()
                        } else {
                            self.audioPlayer.play()
                        }
                        moveBars.toggle()
                        withAnimation(.easeOut(duration: 0.2)) {
                            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now()) {
                                transparency = 0.0
                            }
                        }
                    }
                    .font(.headline)
                    .fontWeight(.medium)
                    .buttonBorderShape(.roundedRectangle)
                    .buttonStyle(.bordered)
                }

                .onAppear {
                    let sound = Bundle.main.path(forResource: "water", ofType: "mp3")
                    self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                    self.audioPlayer.pause()
                }
            }

            VStack {
                CustomBackButton(
                    trackItem: trackItem,
                    dismissAction: dismiss,
                    enforce: false
                )
                Spacer()
            }
        }
        .ultraThinInterface()
    }
}

#if DEBUG
#Preview {
    CalmListenView( trackItem: TrackItem() )
}
#endif
