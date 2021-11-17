//
//  ContentView.swift
//  Flashdecks
//
//  Created by Antonio on 12/11/21.
//

import SwiftUI

struct ContentView: View {
    
    let flashdecks = UseFlashdecks()

    
    @State var description: String = ""
    @State var show: String = ""
    @State var deck: Flashdeck? = nil
    @State var nameCard: String = ""
    @State var definitionCard: String = ""
    @State var keywords = ["", "", ""]
    @State var name: String = ""
    
    
    
    
    var body: some View {
        
       // Text("Hello, world!")
           // .padding()
        VStack{
        Form {
            TextField("name", text: $name)
            TextField("description", text: $description)
           
           
           
            
            Button("Save") {
                flashdecks.createDeck(name: name, description: description)
                deck = flashdecks.getDeckWithName(deckname: name)!
                show = deck!.description
                
                
                
                
            }
            Button("Delete") {
                
                flashdecks.deleteDeck(deckToDelete: deck!)
                
            }
            Button("Update") {
              
                name = deck!.name
                description = deck!.description
                
            }
            Button("Save Update") {
                deck!.name = name
                deck!.description = description
              
                flashdecks.updateDeck(newDeck: deck!)
                
            }
            
            

        }
        
        Form{
            TextField("namecard", text: $nameCard)
            TextField("definition", text: $definitionCard)
            TextField("keyword", text: $keywords[0])
            TextField("keyword", text: $keywords[1])
            TextField("keyword", text: $keywords[2])
            
            Button("Save"){
                print(nameCard)
               
               
                
                flashdecks.createCard(newFlashcard: Flashcard(id: "", name: nameCard, Keywords: keywords, definition: definitionCard), deckId: deck!.id)
            }
        }}
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
