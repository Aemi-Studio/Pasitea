//
//  TrackItemWrapper.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 30/10/23.
//

import Foundation
import SwiftData

class TrackItemWrapper {
    private var item: TrackItem

    init(_ item: TrackItem) {
        self.item = item
    }

    public func reset(_ modelContext: ModelContext, tags: String...) -> TrackItemWrapper {
        for tag in tags {
            self.item.addTags( tag )
        }
        self.item.endsNow().saveInto(modelContext)
        self.item = TrackItem(type: self.item.typeAsTrackType, previousId: self.item.previousId ?? self.item.id)
        return self
    }

    public func startsNow(_ tags: String...) -> TrackItemWrapper {
        self.item.startsNow()
        for tag in tags {
            self.item.addTags( tag )
        }
        return self
    }

    public func endsNow(_ tags: String...) -> TrackItemWrapper {
        self.item.startsNow()
        for tag in tags {
            self.item.addTags( tag )
        }
        return self
    }

    public func saveInto(_ modelContext: ModelContext) {
        self.item.saveInto(modelContext)
    }
}
