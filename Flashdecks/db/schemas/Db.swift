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

public struct Flashdecks: Codable {
    var id: String
    var name: String
    var flashcards: [Flashcards]
}

public struct Flashcards: Codable {
    var id: String
    var name: String
    var description: String
}
