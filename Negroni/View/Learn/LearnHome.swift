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

            List {

                ForEach(modelData.learnItems) { learnItem in

                    NavigationLink {
                        LearnDetail(learnItem: learnItem)
                    } label: {
                        LearnRow(learnItem: learnItem)
                    }
                }

            }


        } detail: {
            Text("Select a Topic")
        }
    }
}

#Preview {
    LearnHome()
        .environment(ModelData())
}
