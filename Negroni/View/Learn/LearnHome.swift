//
//  LearnHome.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct LearnHome: View {

    @Environment(ModelData.self) var modelData

    var body: some View {
        NavigationSplitView {
            ZStack {
                List {
                    ForEach(modelData.learnItems) { learnItem in
                        NavigationLink {
                            LearnDetail(learnItem: learnItem)
                        } label: {
                            LearnRow(learnItem: learnItem)
                        }
                    }
                }
                .listRowSpacing(16)
            }
            .navigationTitle("Learn")
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)


        } detail: {
            Text("Select a Topic")
        }
    }
}


#if DEBUG
#Preview {
    LearnHome()
        .environment(ModelData())
}
#endif
