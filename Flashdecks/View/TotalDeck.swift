//
//  SeeAllDeck.swift
//  Flashdecks
//
//  Created by felice di palma on 19/11/21.
//

import SwiftUI

struct TotalDeck: View {
    let useFlashdecks: UseFlashdecks
    
    @State var selectedDeck : Flashdeck? = nil
    //VAR PER IL REDIRECT DOPO IL DELETE DEL DECK
    @State var isActive : Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            /*  HStack{
             Text("Decks")
             .fontWeight(.bold)
             .font(.largeTitle)
             //  .padding([.top, .leading], 10.0)
             
             
             }*/
            
            
            
            visualDeck()
        }.padding()
            .navigationTitle("All Decks")
            .navigationBarTitleDisplayMode(.large)
        
        
        
    }
    private func visualDeck() -> some View{
        
        ScrollView(.vertical, showsIndicators: false) {
            
            
            VStack {
                if selectedDeck != nil {
                    NavigationLink(
                        destination: FlashcardList(useFlashdecks: useFlashdecks, deck:selectedDeck!),
                        isActive: self.$isActive)
                    { }
                    .isDetailLink(false)
                }
            }.hidden()
            
            ForEach(useFlashdecks.deckList){deck in
                Button(action: {
                    self.selectedDeck = deck
                    self.isActive = true
                }, label: {
                    DeckRow(deck: deck)
                })
                
            }
            
            //OLD VERSION
            /*   ForEach(useFlashdecks.deckList) { deck in
             NavigationLink(
             destination: FlashcardList(rootIsActive: self.$isActive),
             isActive: self.$isActive,
             label: {
             DeckRow(deck: deck)
             })  .isDetailLink(false)
             
             }*/
            
            
        }.navigationBarTitleDisplayMode(.large)
    }
    
}



struct TotalDeck_Previews: PreviewProvider {
    static var previews: some View {
        TotalDeck(useFlashdecks: UseFlashdecks())
    }
}
