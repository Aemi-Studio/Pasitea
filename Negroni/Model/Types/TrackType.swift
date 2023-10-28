//
//  TrackType.swift
//  Negroni
//
//  Created by Guillaume Coquard on 27/10/23.
//

import Foundation

public enum TrackType: String, Codable, CaseIterable {
    case none = "Exercise"
    case steps = "5 Steps"
    case breathing = "Breathing"
    case listening = "Listening"
    case feeling = "Feeling"
}
