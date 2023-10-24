//
//  TrackItem.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation
import SwiftData

@Model
public final class TrackItem: Identifiable {

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
    private var tags: [String] = []
    public var startDate: Date = Date.now
    public var endDate: Date? = Date.now
    public var previousId: UUID? = nil
    private var saved: Bool = false
    private var deleted: Bool = false


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
        type: TrackType? = TrackItem.TrackType.none,
        desc: String? = "",
        tags: [String]? = [],
        startDate: Date? = Date.now,
        endDate: Date? = Date.now,
        previousId: UUID? = nil
    ) {
        self.id = UUID()
        self.type = type?.rawValue ?? TrackItem.TrackType.none.rawValue
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

extension TrackItem {
    
    public func addTags(_ tags: String...) -> TrackItem {
        for tag in tags {
            self.tags.append(tag)
        }
        return self
    }

    public func saveInto(_ modelContext: ModelContext, _ endDate: Date? = Date.now) {
        if !saved {
            self.saved = true
            self.endDate = endDate!
            modelContext.insert(self)
            do {
                try modelContext.save()
            } catch {
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
    }

    public func deleteFrom(_ modelContext: ModelContext) {
        if !deleted {
            modelContext.delete(self)
            self.deleted = true
            do {
                try modelContext.save()
            } catch {
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
    }

    public func to(_ type: TrackType) -> TrackItem {
        self.type = type.rawValue
        print(self.type)
        return self
    }

    public func startsAt(_ date: Date) -> TrackItem {
        self.startDate = date
        return self
    }

    public func endsAt(_ date: Date) -> TrackItem {
        self.endDate = date
        return self
    }

    public func startsNow() -> TrackItem {
        let date = Date.now
        self.startDate = date
        self.endDate = date
        return self
    }
    
    public func endsNow() -> TrackItem {
        self.endDate = Date.now
        return self
    }
}
