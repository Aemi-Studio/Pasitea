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

    enum Tab {
        case Calm
        case Track
        case Learn
    }

    var body: some View {
        TabView(selection: $selection) {
            CalmHome()
                .tabItem {
                    Label("Calm", systemImage: "water.waves")
                }
                .tag(Tab.Calm)

            TrackHome()
                .tabItem {
                    Label("Track", systemImage: "point.bottomleft.filled.forward.to.point.topright.scurvepath")
                }
                .tag(Tab.Track)

            LearnHome()
                .tabItem {
                    Label("List", systemImage: "books.vertical")
                }
                .tag(Tab.Track)
        }

    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
