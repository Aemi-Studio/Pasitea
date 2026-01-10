//
//  PasiteaApp.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 16/10/23.
//

import SwiftData
import SwiftUI

enum PasiteaMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [PasiteaSchemaV1.self]
    }

    static var stages: [MigrationStage] {
        []
    }
}

@main
struct PasiteaApp: App {
    @State private var modelData = ModelData()

    private let container: ModelContainer

    init() {
        do {
            container = try ModelContainer(for: TrackItem.self, migrationPlan: PasiteaMigrationPlan.self)
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
            exit(EXIT_FAILURE)
        }
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(modelData)
        }
        .modelContainer(container)
    }
}
