//
//  PasiteaHelper.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 27/10/23.
//

import Foundation

public final class Helper {
    public static var dateFormatter: DateComponentsFormatter {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.day, .hour, .minute]
        dateFormatter.unitsStyle = .brief
        return dateFormatter
    }
}

// MARK: This is shit.
public func maybeEvery(_ count: Int, _ condition: Bool = false) -> String {
    if count == 0 || condition {
        return "every"
    } else {
        return count.description
    }
}

// MARK: This is another shit.
public func plural(_ count: Int) -> String {
    if count == 0 || count > 1 {
        return "s"
    } else {
        return ""
    }
}

// MARK: This is yet again another shit.
public func isFeeling(_ item: TrackItem) -> Bool {
    return item.typeAsTrackType == .feeling
}
