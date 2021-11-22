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

public struct Flashdeck: Codable, Identifiable {
    public var id: String
    var description: String
    var name: String
    var flashcards: [Flashcard]
    var statistics: DeckStatistics
}

public struct Flashcard: Codable, Identifiable {
    public var id: String
    var name: String
    var keywords: [String]
    var definition: String
}
