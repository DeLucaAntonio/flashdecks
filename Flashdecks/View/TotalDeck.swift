//
//  SeeAllDeck.swift
//  Flashdecks
//
//  Created by felice di palma on 19/11/21.
//

import SwiftUI

struct TotalDeck: View {
    @ObservedObject var useFlashdecks: UseFlashdecks
    //VAR PER IL REDIRECT DOPO IL DELETE DEL DECK
    @State var isActive : Bool = false
    @State var tapLong: Bool = false
    
    //Long press var
    @State var longPressed: Bool = false
    @State var isActiveLong: Bool = false
    
//    @State var selectedDeck : Flashdeck? = nil
    
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
//                if diocane == true{
                NavigationLink(
                    destination: GameStartScreenView()
                        .navigationBarHidden(true),
                    isActive: self.$isActiveLong)
                    {}
                    .isDetailLink(false)
                    
//                }
                if useFlashdecks.selectedDeck != nil {
                    NavigationLink(
                        destination: FlashcardList(useFlashdecks: useFlashdecks, deck:useFlashdecks.selectedDeck!),
                        isActive: self.$isActive)
                    { }
                    .isDetailLink(false)
                }
               
            }.hidden()
            
            
            ForEach(useFlashdecks.deckList){deck in
                Button(action: {
                    
                    
                }, label: {
                    DeckRow(deck: deck)
                }).simultaneousGesture(
                    LongPressGesture()
                        .onEnded { _ in
                           
                            self.useFlashdecks.selectedDeck = deck
                            self.isActive = true
                            print("Loooong")
                        }
                )
                    .highPriorityGesture(TapGesture()
                                            .onEnded { _ in
                        print("Tap")
                        self.isActiveLong.toggle()
                     
                    })
                    
                
                /*.onLongPressGesture(perform:
                 {
                 
                 })*/
                
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
