//
//  TrackItemWrapper.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 30/10/23.
//

import Foundation

@MainActor
final class TrackItemWrapper {
    private var item: TrackItem

    init(_ item: TrackItem) {
        self.item = item
    }

    @discardableResult
    public func reset(_ persistence: PersistenceFacade, tags: String...) -> TrackItemWrapper {
        for tag in tags {
            self.item.addTags(tag)
        }
        persistence.save(self.item.endsNow())
        self.item = TrackItem(type: self.item.typeAsTrackType, previousId: self.item.previousId ?? self.item.id)
        return self
    }

    @discardableResult
    public func startsNow(_ tags: String...) -> TrackItemWrapper {
        self.item.startsNow()
        for tag in tags {
            self.item.addTags(tag)
        }
        return self
    }

    @discardableResult
    public func endsNow(_ tags: String...) -> TrackItemWrapper {
        self.item.endsNow()
        for tag in tags {
            self.item.addTags(tag)
        }
        return self
    }

    public func save(_ persistence: PersistenceFacade) {
        persistence.save(self.item)
    }
}
