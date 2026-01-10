//
//  CalmSounds.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 29/10/23.
//

import Foundation

struct CalmSound: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var title: String
    var filename: String
}
