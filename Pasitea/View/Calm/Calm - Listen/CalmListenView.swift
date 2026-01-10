//
//  CalmListenView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import AVKit
import Combine
import SwiftData
import SwiftUI

struct CalmListenView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @Environment(\.modelContext) var modelContext: ModelContext
    @Environment(ModelData.self) var modelData: ModelData

    @State private var audioPlayer: AVAudioPlayer?
    @State private var moveBars = false
    @State private var started = false
    @State private var alreadyPlayed = false
    @State private var selectedSound = 1

    @State private var currentTime: Double = 0
    @State private var duration: Double = 100

    func closeAction() {
        PersistenceFacade(modelContext: modelContext).save(trackItem)
    }

    var timer: Publishers.Autoconnect<Timer.TimerPublisher> {
        Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    }

    var sounds: [CalmSound] { modelData.calmSounds }
    var trackItem: TrackItem = TrackItem(type: .listening)

    private var item: TrackItemWrapper { TrackItemWrapper(trackItem) }
    private var persistence: PersistenceFacade { PersistenceFacade(modelContext: modelContext) }

    var animation: Animation {
        moveBars
            ? .timingCurve(0.3, 0, 0.8, 1, duration: 0.5).repeatForever()
            : .timingCurve(0.3, 0, 0.8, 1, duration: 0.5)
    }

    private func makeAudioPlayer(soundFilename: String) -> AVAudioPlayer? {
        guard let soundPath = Bundle.main.path(forResource: soundFilename, ofType: "mp3") else {
            return nil
        }

        do {
            return try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
        } catch {
            return nil
        }
    }

    private func action() {
        if !alreadyPlayed {
            started = true
            alreadyPlayed = true
        }
        if moveBars {
            audioPlayer?.pause()
            item.reset(persistence)
        } else {
            if let audioPlayer {
                audioPlayer.play()
                item.startsNow(sounds[selectedSound - 1].filename)
            } else {
                let soundFilename = sounds[selectedSound - 1].filename
                guard let player = makeAudioPlayer(soundFilename: soundFilename) else {
                    return
                }

                player.stop()
                player.prepareToPlay()
                player.numberOfLoops = -1
                self.audioPlayer = player
                self.currentTime = 0
                self.duration = player.duration
                self.moveBars = false
                self.alreadyPlayed = false
            }
        }
        moveBars.toggle()
    }

    private func bar(low: CGFloat = -1.0, high: CGFloat = 1.0) -> some View {
        UnevenRoundedRectangle(
            cornerRadii: .init(
                topLeading: 20,
                bottomLeading: 20,
                bottomTrailing: 20,
                topTrailing: 20
            ), style: .continuous
        )
        .fill(.customBackground)
        .frame(height: (moveBars ? high * 64 : low * 32))
        .frame(height: 64, alignment: .center)
    }

    var body: some View {
        ZStack {
            GradientView()

            VStack(alignment: .center, spacing: 56) {
                Button(action: action) {
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
                            if moveBars {
                                item.endsNow().save(persistence)
                            }
                            moveBars = false
                            audioPlayer?.stop()
                        }
                    }
                    .padding(.all, 32)
                    .background(.accent)
                    .clipShape(.circle)
                }
                .buttonStyle(.plain)
                .frame(width: 154, height: 154)

                Picker(selection: $selectedSound, label: Text("Sounds")) {
                    ForEach(Array(sounds.enumerated()), id: \.element.id) { index, sound in
                        Text(sound.title).tag(index + 1)
                    }
                }
                .pickerStyle(.menu)
                .focusable()
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(maxWidth: .infinity)
                        .background(.regularMaterial)
                        .opacity(0.1)
                }
                .onChange(of: selectedSound) {
                    if let audioPlayer {
                        audioPlayer.stop()
                        item.save(persistence)
                    }

                    guard let player = makeAudioPlayer(soundFilename: sounds[selectedSound - 1].filename) else {
                        return
                    }

                    player.stop()
                    player.prepareToPlay()
                    player.numberOfLoops = -1

                    self.audioPlayer = player
                    self.currentTime = 0
                    self.duration = player.duration
                    self.moveBars = false
                    self.alreadyPlayed = false
                }
                .onAppear {
                    guard let player = makeAudioPlayer(soundFilename: sounds[selectedSound - 1].filename) else {
                        return
                    }

                    player.prepareToPlay()
                    player.numberOfLoops = -1
                    self.audioPlayer = player
                    self.currentTime = 0
                    self.duration = player.duration
                    self.moveBars = false
                    self.alreadyPlayed = false
                }

                HStack {
                    Button("Placeholder", action: action)
                        .customHaptic(moveBars)
                        .foregroundStyle(.clear)
                        .pasiteaButtonStyle(.bordered)
                        .background {
                            GeometryReader { geo in
                                ProgressView(value: self.currentTime, total: self.duration) {
                                    Label(
                                        moveBars ? "Pause" : alreadyPlayed ? "Resume" : "Play",
                                        systemImage: moveBars ? "pause" : alreadyPlayed ? "arrow.clockwise" : "play"
                                    )
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                }
                                .onReceive(timer) { _ in
                                    if let audioPlayer {
                                        withAnimation(.linear(duration: 0.5)) {
                                            self.currentTime = audioPlayer.currentTime
                                            self.duration = audioPlayer.duration
                                        }
                                    } else {
                                        withAnimation(.linear(duration: 0.5)) {
                                            self.currentTime = 0
                                            self.duration = 100
                                        }
                                    }
                                }
                                .progressViewStyle(CustomProgressStyle())
                                .frame(width: geo.size.width, height: geo.size.height)
                                .scaledToFill()
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .frame(height: 64)
            }

            VStack {
                CustomBackButton(
                    dismissAction: dismiss,
                    customAction: closeAction,
                    enforce: false,
                    display: [.info, .close]
                ) {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Listen")
                            .font(.title2)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                        Group {
                            Text(
                                """
                                Listening to calming sounds is a powerful way to find relaxation and reduce \
                                stress. Whether it's the gentle rush of waves, raindrops falling, \
                                or cats purring, these sounds have the ability to soothe and calm your mind.

                                By immersing yourself in these serene auditory experiences, you can lower \
                                stress levels, ease anxiety, and create a sense of tranquility.

                                It's a simple yet effective method to find peace in a noisy world.
                                """)
                        }
                        .multilineTextAlignment(.leading)
                        .fontWeight(.medium)
                    }
                    .padding()
                    .informationModalStyle()
                }
                Spacer()
            }
        }
        .ultraThinInterface()
    }
}

#if DEBUG
#Preview {
    CalmListenView(trackItem: TrackItem())
}
#endif
