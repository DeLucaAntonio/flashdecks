//
//  DeckRow.swift
//  Flashdecks
//
//  Created by felice di palma on 13/11/21.
//

import SwiftUI

struct DeckRow: View {
    let deck: Deck
    
    var body: some View {
        
        ZStack{
            VStack{
                Text(deck.name)
                .fontWeight(.bold)
                .font(.title)
                //.lineSpacing(24)
                .foregroundColor(.white)
          
            }
            
        }.frame(width: 380, height: 90)
         .background(Color(red: 0.38, green: 0.37, blue: 0.84))
         .cornerRadius(10)
        
    }
}

struct DeckRow_Previews: PreviewProvider {
    static var previews: some View {
        DeckRow(deck: Deck.testOggetto()[1])
    }
}
