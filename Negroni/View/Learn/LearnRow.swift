//
//  LearnRow.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import SwiftUI

struct LearnRow: View {

    var learnItem: Learn

    var body: some View {
        VStack {
            Text(learnItem.title)
        }
    }
}

#if DEBUG
#Preview {
    LearnRow(learnItem: ModelData().learnItems[0])
}
#endif
