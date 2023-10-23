//
//  ContentView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 16/10/23.
//

import SwiftUI

struct ContentView: View {

    @State private var selection: Tab = .Calm

    enum Tab: Int {
        case Calm = 1
        case Track = 2
        case Learn = 3
    }

    var body: some View {
        TabView(selection: $selection) {
            Group {

                ZStack {
                    CalmHome()
                }
                .tabItem {
                    Label("Calm", systemImage: "water.waves")
                }
                .tag(Tab.Calm.rawValue)

                ZStack {
                    TrackHomeBeta()
                }
                .tabItem {
                    Label("Track", systemImage: "point.bottomleft.filled.forward.to.point.topright.scurvepath")
                }
                .tag(Tab.Track.rawValue)

                ZStack {
                    LearnHome()
                }
                .tabItem {
                    Label("Learn", systemImage: "books.vertical")
                }
                .tag(Tab.Track.rawValue)
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
