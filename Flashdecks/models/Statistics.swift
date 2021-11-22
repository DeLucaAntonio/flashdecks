//
//  Statistics.swift
//  Flashdecks
//
//  Created by Antonio on 21/11/21.
//

import Foundation

//Statistiche caricate all'inizio dalla nostra app
public struct GlobalStatistics: Codable, Identifiable {
    public var id: UUID
    var totalSuccess: Float
    var completedSession: Int
    var averageDuration: Double
}

public struct DeckStatistics: Codable {
    var totalSuccess: Float
    var averageDuration: Double
    var averageDurationList: [Double]
}

public struct GameStatistics {
    var totalTime: Int // Totale durata del gioco
    var cardsResult: [CardStatistic]
}

public struct CardStatistic {
    var time: Int
    var result: Bool // Risposta alla domanda true giusta, false sbagliata
}
