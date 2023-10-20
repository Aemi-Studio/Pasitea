//
//  TrackItem.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation
import SwiftData

@Model
public final class TrackItem:  Identifiable {

    public enum TrackType: String, Codable, CaseIterable {
        case none = "Exercise"
        case steps = "5 Steps"
        case breathing = "Breathing"
        case listening = "Listening"
        case feeling = "Feeling"
    }

    @Attribute(.unique) public let id: UUID
    public var date: Date
    public var title: String
    public var desc: String = ""
    public var tags: [String] = []
    var type: TrackType.RawValue

    enum TrackItemCodingKeys: CodingKey {
        case id
        case date
        case title
        case desc
        case tags
        case type
    }

    init(_ title: String,_ desc: String?, type: TrackType.RawValue?, tags: [String]?, date: Date?) {
        self.id = UUID()
        self.title = title
        self.desc = desc ?? ""
        self.type = type ?? "Exercise"
        self.tags = tags ?? []
        self.date = date ?? Date.now
    }
}

extension TrackItem {
    @Transient
    var trackType: TrackType {
        TrackType(rawValue: self.type) ?? .none
    }
}
