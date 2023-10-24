//
//  ModelData.swift
//  Negroni
//
//  Created by Guillaume Coquard on 17/10/23.
//

import Foundation

@Observable
class ModelData {
    var learnItems: [Learn] = load("learnData.json")
    var calmSteps: [CalmStep] = load("calmData.json")
}

func load<T: Decodable>(_ filename: String) -> T {

    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        print("Couldn't load \(filename) from main bundle:\n")
        fatalError(error.localizedDescription)
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Couldn't parse \(filename) as \(T.self):")
        fatalError(error.localizedDescription)
    }
}

