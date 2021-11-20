//
//  DeckRow.swift
//  Flashdecks
//
//  Created by felice di palma on 13/11/21.
//

import SwiftUI

struct DeckRow: View {
    let deck: Flashdeck
    
    var body: some View {
        
        ZStack(alignment: .leading){
            Rectangle()
                .frame(width: 380, height: 100)
                .foregroundColor(Color(UIColor(named: "PrimaryViolet")!))
                .cornerRadius(10)
                .padding(.top,10)
            
            Text(deck.name)
                .fontWeight(.semibold)
                .font(.title)
                .multilineTextAlignment(.leading)
            //.lineSpacing(24)
                .foregroundColor(.white)
                .padding(.leading,30)
                .padding(.bottom,30)
            
            Text("10%")
                .fontWeight(.heavy)
               // .font(.title)
                .multilineTextAlignment(.leading)
            //.lineSpacing(24)
                .foregroundColor(Color(UIColor(named: "percentageColor")!))
                .padding(.top,60)
                .padding( .leading, 30.0)
                .font(.system(size: 40))
        }
        
    }
    
}


//struct DeckRow_Previews: PreviewProvider {
//    static var previews: some View {
//        DeckRow(deck: Flashdeck)
//    }
//}
