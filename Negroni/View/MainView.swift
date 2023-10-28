//
//  ContentView.swift
//  Negroni
//
//  Created by Guillaume Coquard on 16/10/23.
//

import SwiftUI

struct MainView: View {
    enum Tab: Int {
        case calm = 1
        case track = 2
    }

    var body: some View {
        TabView {
            CalmHome()
                .tabItem {
                    Label("Calm", systemImage: "water.waves")
                }
                .tag(Tab.calm.rawValue)

            TrackHome()
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
