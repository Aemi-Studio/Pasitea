//
//  ContentView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 16/10/23.
//

import SwiftUI

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
            CalmHome()
                .tabItem {
                    Label("Calm", systemImage: "water.waves")
                }
                .tag(Tab.Calm.rawValue)

            TrackHome()
                .tabItem {
                    Label("Track", systemImage: "point.bottomleft.filled.forward.to.point.topright.scurvepath")
                }
                .tag(Tab.Track.rawValue)

            LearnHome()
                .tabItem {
                    Label("List", systemImage: "books.vertical")
                }
                .tag(Tab.Track.rawValue)
        }

    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
