//
//  Card.swift
//  Flashdecks
//
//  Created by felice di palma on 12/11/21.
//

import Foundation
import SwiftUI

class Card: Identifiable {
    
    init(name: String, description: String, keywords: [String]){
        self.name = name
        self.description = description
        self.keywords = [String]()
    }
    
    let id: String = UUID().uuidString
    var name: String
    var description: String
    var keywords: [String]
    
}

#if DEBUG

extension Card{
    
    static func testOggetto() -> [Card] {
        
        return [
            Card.init(name: "Integrals",
                     description: "sdjhflqdgflgflgfgewfwefwqff",
                     keywords: ["sadsdadadsasd", "dfqergfqergqerg", "qdgqergqergeqrg"]),
            Card.init(name: "Derivates",
                     description: "aaaaaaaaaaaaaaaaaaaaaaaaaaa",
                     keywords: ["aaaaa", "bbbbbb", "ccccc"]),
            Card.init(name: "Limits",
                     description: "bbbbbbbbbbbbbbbbbbbbbbbbbbb",
                     keywords: ["ddddd", "eeeee", "fffff"]),
            Card.init(name: "Functions",
                     description: "ccccccccccccccccccccccccccc",
                     keywords: ["ggggg", "hhhhh", "iiiii"]),
            Card.init(name: "Differential equation",
                     description: "ddddddddddddddddddddddddddd",
                     keywords: ["lllll", "mmmmm", "nnnnn"]),
            Card.init(name: "Function study",
                     description: "eeeeeeeeeeeeeeeeeeeeeeeeeee",
                     keywords: ["ooooo", "vvvvv", "qqqqq"]),
            
        ]
          
    }
    
}




#endif
