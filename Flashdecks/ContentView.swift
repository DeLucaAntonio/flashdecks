//
//  ContentView.swift
//  Flashdecks
//
//  Created by Antonio on 12/11/21.
//

import SwiftUI

struct ContentView: View {
    
    let flashdecks = UseFlashdecks()
    @State var name: String = ""
    @State var description: String = ""
    @State var show: String = ""
    
    
    var body: some View {
       // Text("Hello, world!")
           // .padding()
        VStack {
            TextField("name", text: $name)
            TextField("description", text: $description)
            Text(show)
            Button("Save") {
                flashdecks.createDeck(name: name, description: description)
                var deck = flashdecks.getDeckWithName(deckname: "Analisi 1")
                show = deck!.description
                
                
                
               
            }
            

            }.navigationBarTitle("Settings")
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
