//
//  LearnDetail.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct LearnDetail: View {

    var learnItem: Learn

    var body: some View {
        VStack {
            Text(learnItem.title)

            Text(learnItem.content)
        }
    }
}

#Preview {
    LearnDetail(learnItem: ModelData().learnItems[0])
}
