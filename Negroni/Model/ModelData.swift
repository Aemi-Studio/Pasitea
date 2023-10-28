//
//  ModelData.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation

@Observable
class ModelData {
    let calmSteps: [CalmStep] = [
        CalmStep(
            title: "Look",
            headline: "Look around you",
            subheadline: "Focus on 5 different objects",
            items: 5,
            image: "calm_step_1.png",
            id: 0
        ),
        CalmStep(
            title: "Listen",
            headline: "Listen to 4 different sounds",
            subheadline: "",
            items: 4,
            image: "calm_step_2.png",
            id: 1
        ),
        CalmStep(
            title: "Touch",
            headline: "Touch 3 objects",
            subheadline: "",
            items: 3,
            image: "calm_step_3.png",
            id: 2
        ),
        CalmStep(
            title: "Smell",
            headline: "Identify 2 different smells",
            subheadline: "",
            items: 2,
            image: "calm_step_4.png",
            id: 3
        ),
        CalmStep(
            title: "Taste",
            headline: "Name 1 thing you can taste",
            subheadline: "",
            items: 1,
            image: "calm_step_5.png",
            id: 4
        )
    ]
}
