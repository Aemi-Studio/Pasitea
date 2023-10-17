//
//  CalmStep.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation

struct CalmStep: Codable, Hashable, Identifiable {
    var title: String
    var headline: String
    var subheadline: String
    var items: Int
    var image: String
    var id: Int
}
