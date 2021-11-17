//
//  Decks.swift
//  Flashdecks
//
//  Created by felice di palma on 12/11/21.
//

import Foundation
import SwiftUI

class Deck: Identifiable {
    
    init(name: String, description: String){
        self.name = name
        self.description = description
       // self.cards = [Card]()
    }
    
    let id: String = UUID().uuidString
    var name: String
    var description: String
    //var cards: [Card] = []
    
}

#if DEBUG

extension Deck{
    
    static func testOggetto() -> [Deck] {
        
        return [
            Deck.init(name: "Calculus1",
                     description: "aaaaaaaaaaaaaaaaaaaaaaaaa"
        
                      ),
            Deck.init(name: "Economia",
                     description: "bbbbbbbbbbbbbbbbbbbbbbbbb"
                      ),
            Deck.init(name: "Sistemi1",
                     description: "ccccccccccccccccccccccccc"
                     
                      ),
            Deck.init(name: "Reti1",
                     description: "ddddddddddddddddddddddddd"
                     
                      ),
            Deck.init(name: "Algebra",
                     description: "eeeeeeeeeeeeeeeeeeeeeeeee"
                     
                      )
            
        ]
          
    }
    
}




#endif
