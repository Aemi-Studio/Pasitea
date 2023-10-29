//
//  TrackItem.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
public final class TrackItem: Identifiable {
    @Attribute(.unique) public let id: UUID
    public var type: TrackType.RawValue = TrackType.none.rawValue
    public var desc: String = ""
    public var tags: [String] = []
    public var startDate: Date = Date.now
    public var endDate: Date = Date.now
    public var previousId: UUID?
    private var saved: Bool = false
    private var deleted: Bool = false
    private var popoverPresented: Bool = false

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

    init(_ item: TrackItem ) {
        self.id = UUID()
        self.type = item.type
        self.desc = item.desc
        self.tags = item.tags
        self.startDate = item.startDate
        self.endDate = item.endDate
        self.previousId = item.previousId
    }
}

extension TrackItem {
    @Transient
    public var isPopoverPresented: Binding<Bool> {
        get { Binding.constant(self.popoverPresented) }
        set { if self.popoverPresented != newValue.wrappedValue { self.popoverPresented.toggle() } }
    }

    @Transient
    public var typeAsTrackType: TrackType {
        get {
            (TrackType(rawValue: self.type))!
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
