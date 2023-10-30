//
//  ModelData.swift
//  Pasitea
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation

@Observable
class ModelData {
    let calmSteps: [CalmStep] = [
        CalmStep(
            title: "Look",
            headline: "Explore Your Surroundings",
            subheadline: "Focus on 5 Different Objects",
            items: 5,
            image: "eye",
            id: 0
        ),
        CalmStep(
            title: "Listen",
            headline: "Tune into Your Environment",
            subheadline: "Listen to 4 Different Sounds",
            items: 4,
            image: "ear",
            id: 1
        ),
        CalmStep(
            title: "Touch",
            headline: "Engage Your Sense of Touch",
            subheadline: "Touch 3 Objects",
            items: 3,
            image: "hand.tap",
            id: 2
        ),
        CalmStep(
            title: "Smell",
            headline: "Identify Soothing Scents",
            subheadline: "Distinguish 2 Different Smells",
            items: 2,
            image: "nose",
            id: 3
        ),
        CalmStep(
            title: "Taste",
            headline: "Remember Something You Like",
            subheadline: "Focus on Something You Can Taste",
            items: 1,
            image: "cup.and.saucer",
            id: 4
        )
    ]
    let calmSounds: [CalmSound] = [
        CalmSound(title: "Birds", filename: "birds-1"),
        CalmSound(title: "Cat Purring #1", filename: "cat-1"),
        CalmSound(title: "Cat Purring #2", filename: "cat-2"),
        CalmSound(title: "River", filename: "river-1"),
        CalmSound(title: "Sea", filename: "sea-1"),
        CalmSound(title: "Wind #1", filename: "wind-1"),
        CalmSound(title: "Wind #2", filename: "wind-2")
    ]
}
