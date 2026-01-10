//
//  TrackItem.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation
import SwiftData
import SwiftUI

public enum PasiteaSchemaV1: VersionedSchema {
    public static var versionIdentifier: Schema.Version { Schema.Version(1, 0, 0) }

    public static var models: [any PersistentModel.Type] {
        [TrackItem.self]
    }

    @Model
    public final class TrackItem: Identifiable {
        @Attribute(.unique) public var id: UUID
        public var type: TrackType.RawValue = TrackType.none.rawValue
        public var desc: String = ""
        public var tags: [String] = []
        public var startDate: Date = Date.now
        public var endDate: Date = Date.now
        public var previousId: UUID?

        init(
            type: TrackType = TrackType.none,
            desc: String = "",
            tags: [String] = [],
            startDate: Date = Date.now,
            endDate: Date = Date.now,
            previousId: UUID? = nil
        ) {
            self.id = UUID()
            self.type = type.rawValue
            self.desc = desc
            self.tags = tags
            self.startDate = startDate
            self.endDate = endDate
            self.previousId = previousId ?? nil
        }

        init(_ item: TrackItem) {
            self.id = UUID()
            self.type = item.type
            self.desc = item.desc
            self.tags = item.tags
            self.startDate = item.startDate
            self.endDate = item.endDate
            self.previousId = item.previousId
        }
    }
}

public typealias TrackItem = PasiteaSchemaV1.TrackItem

extension TrackItem {
    @Transient
    public var typeAsTrackType: TrackType {
        get {
            TrackType(rawValue: self.type) ?? .none
        }
        set(rawValue) {
            self.type = rawValue.rawValue
        }
    }

    @Transient
    public var typeAsInt: Int {
        get {
            return TrackType.allCases.firstIndex { value in value == self.typeAsTrackType } ?? 0
        }
        set(index) {
            self.type = TrackType.allCases[index].rawValue
        }
    }
}

extension TrackItem {
    @discardableResult
    public func addTags(_ tags: String...) -> TrackItem {
        for tag in tags {
            self.tags.append(tag)
        }
        return self
    }

    @discardableResult
    public func to(_ type: TrackType) -> TrackItem {
        self.type = type.rawValue
        print(self.type)
        return self
    }

    @discardableResult
    public func startsAt(_ date: Date) -> TrackItem {
        self.startDate = date
        return self
    }

    @discardableResult
    public func endsAt(_ date: Date) -> TrackItem {
        self.endDate = date
        return self
    }

    @discardableResult
    public func startsNow() -> TrackItem {
        let date = Date.now
        self.startDate = date
        self.endDate = date
        return self
    }

    @discardableResult
    public func endsNow() -> TrackItem {
        self.endDate = Date.now
        return self
    }
}

@MainActor
struct PersistenceFacade {
    let modelContext: ModelContext

    func save(_ item: TrackItem, endDate: Date? = nil) {
        if let endDate {
            item.endDate = endDate
        }
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
    }

    func delete(_ item: TrackItem) {
        modelContext.delete(item)
        do {
            try modelContext.save()
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
    }

    func delete(_ items: [TrackItem]) {
        for item in items {
            modelContext.delete(item)
        }
        do {
            try modelContext.save()
        } catch {
            #if DEBUG
            print(error.localizedDescription)
            #endif
        }
    }
}
