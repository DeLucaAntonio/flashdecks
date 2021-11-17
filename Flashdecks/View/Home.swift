//
//  ContentView.swift
//  Flashdecks
//
//  Created by Antonio on 12/11/21.
//

import SwiftUI

struct Home: View {
    
    @State var ore: String = "1"
    @State var minuti: String = "30"
    @State var secondi: String = "20"
    @State var successo: String = "70"
    @State var sessionComplete: String = "26"
   
    @State var buttonPressed: Bool = false
    var collectionDecks: [Deck] = []
    
    
    var body: some View {
        
        NavigationView{
            
            VStack(alignment: .leading) {
                
                HStack() {
                    
                    Text("Flashdecks")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .padding(.top, 10.0)
            
                    Spacer()
                    
                
                    Button {
                        self.buttonPressed.toggle()
                    } label: {
                        Label("", systemImage: "plus")
                    }.padding(.top, 10.0)
                        .font(.title)
                        
                        
                 
                      
                }.padding(.top, -49)
               
                Spacer()
                   
                
                
                HStack{
                    Text("Statistics")
                    .fontWeight(.bold)
                    .font(.title2)
                    .frame(width: 174, alignment: .topLeading)
                    .lineSpacing(28)
                   
                    
                    Spacer()
                    
                    
                }
                .padding(.top, 1.0)
                
                
           
                HStack {
                    
                    AverageDuration(hours: ore, minutes: minuti, seconds: secondi)
                        Spacer()
                    SessionCompleted(sessionCompleted: sessionComplete)
                    
                }
               
                .padding()
            
                TotalSuccess(succes: successo)
                    .padding(.top, -15.0)
                
                HStack{
                    Text("Recent decks")
                    .fontWeight(.bold)
                    .font(.title2)
                    .frame(width: 174, alignment: .topLeading)
                    .lineSpacing(28)
                    
                    Text("See All →")
                    .fontWeight(.bold)
                    .font(.callout)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 174, alignment: .trailing)
                    .lineSpacing(28)
                    
                }
                .padding()
                
                visualDeck()
               
            }.padding()
          

        }.navigationBarHidden(true)
        
            .sheet(isPresented: $buttonPressed, content: {
                 Text("kdqshfkqwdhf ")
            })
    }
    
    
    private func visualDeck() -> some View{
        
                        ScrollView(.vertical, showsIndicators: true) {
                            
                            ForEach(collectionDecks) { deck in
                                DeckRow(deck: deck)
                            }
                          
                        }//.padding()
                         
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(collectionDecks: Deck.testOggetto())
    }
}
