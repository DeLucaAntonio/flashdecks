//
//  SeeAllDeck.swift
//  Flashdecks
//
//  Created by felice di palma on 19/11/21.
//

import SwiftUI

struct TotalDeck: View {
    @StateObject var useFlashdecks = UseFlashdecks()
    
    var body: some View {
       
        
        VStack(alignment: .leading){
            
            HStack{
                Text("Decks")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding([.top, .leading], 10.0)
                

            }
         
            
            
            visualDeck()
        }.padding()
        
        
    }
    
    
    private func visualDeck() -> some View{
        
        ScrollView(.vertical, showsIndicators: true) {
            
            ForEach(useFlashdecks.deckList) { deck in
                DeckRow(deck: deck)
            }
            
        }
        
    }
    
    
}

struct TotalDeck_Previews: PreviewProvider {
    static var previews: some View {
        TotalDeck()
    }
}
