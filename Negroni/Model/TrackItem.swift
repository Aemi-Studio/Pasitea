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
    public var type: TrackType.RawValue = TrackItem.TrackType.none.rawValue
    public var desc: String = ""
    public var tags: [String] = []
    public var startDate: Date = Date.now
    public var endDate: Date? = Date.now
    public var previousId: UUID? = nil


    enum TrackItemCodingKeys: CodingKey {
        case id
        case type
        case desc
        case tags
        case startDate
        case endDate
        case previousId
    }

    init(
        type: TrackType.RawValue? = TrackItem.TrackType.none.rawValue,
        desc: String? = "",
        tags: [String]? = [],
        startDate: Date? = Date.now,
        endDate: Date? = Date.now,
        previousId: UUID? = nil
    ) {
        self.id = UUID()
        self.type = type ?? TrackItem.TrackType.none.rawValue
        self.desc = desc ?? ""
        self.tags = tags ?? []
        self.startDate = startDate ?? Date.now
        self.endDate = endDate ?? Date.now
        self.previousId = previousId ?? nil
    }
}

extension TrackItem {
    @Transient
    var trackType: TrackType {
        TrackType(rawValue: self.type) ?? .none
    }
}
