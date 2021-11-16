//
//  ContentView.swift
//  Flashdecks
//
//  Created by Antonio on 12/11/21.
//

import SwiftUI

struct ContentView: View {
    
    let flashdecks = UseFlashdecks()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onTapGesture {
                flashdecks.createDeck(name: "Nome", description: "Descri")
            }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
