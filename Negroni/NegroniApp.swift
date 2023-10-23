//
//  NegroniApp.swift
//  Negroni
//
//  Created by Guillaume Coquard on 16/10/23.
//

import SwiftUI
import SwiftData

@main
struct NegroniApp: App {
    
    @State private var modelData = ModelData()

    let container: ModelContainer

    init() {
        container = try! ModelContainer( for: TrackItem.self )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
        .modelContainer(container)
    }
}
