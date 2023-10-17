//
//  TrackItem.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation

public class TrackItem:  Identifiable {

    public var id: UUID = UUID()
    public var date: Date = Date()
    public var title: String

    init(title: String, date: Date) {
        self.id = UUID()
        self.date = date
        self.title = title
    }

    enum TrackType: String {
        case Thought = "Thought"
        case Breathing = "Breathing"
        case Splitted = "Splitted"
        case Listening = "Listening"
    }

}

public class TrackThought: TrackItem {

    var description: String

    init(title: String, description: String, date: Date = Date()) {
        self.description = description
        super.init(title: title, date: date)
    }

}


public class TrackExercise: TrackItem {

    var duration: DateInterval

    init(title: String, date: Date, duration: DateInterval) {
        self.duration = duration
        super.init(title: title, date: date)

    }
}


public class TrackBreathing: TrackExercise {

}

public class TrackListening: TrackExercise {

}

public class TrackSplitted: TrackExercise {

}
