//
//  UseStatistics.swift
//  Flashdecks
//
//  Created by Antonio on 21/11/21.
//

import Foundation

public class UseStatistics: ObservableObject {
    
    @Published var globalStatistics = GlobalStatistics(id: UUID(), totalSuccess: 0, completedSession: 0, averageDuration: 0)
    @Published var avergeHours: String = "0"
    @Published var avergeMinutes: String = "0"
    @Published var avergeSeconds: String = "0"
    
    init(){
        loadStatistics()
    }
    
    let deckList = UseFlashdecks().deckList
    
    func loadStatistics(){
        var totalSuccess: Float = 0
        var averageDuration: Double = 0
        
        if !deckList.isEmpty{
            for deck in deckList {
                totalSuccess += deck.statistics.totalSuccess
                averageDuration += deck.statistics.averageDuration
                print(deck)
            }
            let resultSuccess = totalSuccess / Float(deckList.count)
            let resutlDuration = averageDuration / Double(deckList.count)
            
            globalStatistics.totalSuccess.self = resultSuccess
            globalStatistics.averageDuration.self = resutlDuration
            
            let myDate = Date(timeIntervalSince1970: resutlDuration * 100)
            var calendar = Calendar.current
            calendar.timeZone = TimeZone(abbreviation: "UTC")!
            
            avergeHours = String(calendar.component(.hour, from: myDate))
            avergeMinutes = String(calendar.component(.minute, from: myDate))
            avergeSeconds = String(calendar.component(.second, from: myDate))
        }
        
    }
    
    // Func to register the new score game on db
    func newStatisticsDeck(deck: Flashdeck, results: [CardStatistic]) -> Bool{
        var newDeck = deck
        var averageDurationResults: Double = 0
        var success: Float = 0
        var averageTotalDuration: Double = 0
        
        for result in results {
            averageDurationResults += Double(result.time)
            if result.result {
                success += 1
            }
        }
        
        newDeck.statistics.averageDurationList.append((Double(averageDurationResults) * Double(results.count)) / 100)
        newDeck.statistics.totalSuccess = success * 100 / Float(results.count)
        
        for duration in newDeck.statistics.averageDurationList {
            averageTotalDuration += duration
        }
        
        newDeck.statistics.averageDuration = averageTotalDuration / Double(newDeck.statistics.averageDurationList.count - 1)
        
        return UseFlashdecks().updateDeck(newDeck: newDeck)
    }
    
    // Func to call when a response is gived to a card during the game
    func registerScoreCard(id: String, start: Double, answer: Bool) -> CardStatistic {
        let timeResult = start - NSDate().timeIntervalSince1970 // Calculating time to respond at the answer
        let result = CardStatistic(time: Int(timeResult), result: answer)
        return result
    }
    
    
}
