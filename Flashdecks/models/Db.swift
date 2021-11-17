//
//  dbTypes.swift
//  Flashdecks
//
//  Created by Antonio on 14/11/21.
//

import Foundation

public struct DbConfig: Codable {
    var flashdecks: [String]
}

public struct Flashdeck: Codable {
    var id: String
    var description: String
    var name: String
    var flashcards: [Flashcard]
}

public struct Flashcard: Codable {
    var id: String
    var name: String
    var Keywords: [String]
    var definition: String
}
