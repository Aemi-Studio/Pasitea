//
//  ContentView.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 16/10/23.
//

import SwiftUI

struct MainView: View {
    @State private var isSteppedExercisePresented = false
    @State private var isBreathingExercisePresented = false
    @State private var isListeningExercisePresented = false
    @State private var addViewIsPresented = false

    enum Tab: Int {
        case calm = 1
        case track = 2
    }

    var body: some View {
        TabView {
            CalmScreen()
                .tabItem {
                    Label("Calm", systemImage: "water.waves")
                }
                .tag(Tab.calm.rawValue)

            TrackScreen()
                .tabItem {
                    Label("Track", systemImage: "point.bottomleft.filled.forward.to.point.topright.scurvepath")
                }
                .tag(Tab.track.rawValue)
        }
    }
}

#if DEBUG
#Preview {
    MainView()
        .environment(ModelData())
}
#endif
