//
//  StatsFinalSucc.swift
//  Flashdecks
//
//  Created by felice di palma on 18/11/21.
//

import SwiftUI

struct StatsFinalSucc: View {
    
    let succes: String
    
    var body: some View {
        HStack(spacing: 19.06) {
            
            Text(succes)
            .fontWeight(.bold)
            .font(.largeTitle)
          
            .foregroundColor(Color(UIColor(named:"PrimaryViolet")!))
           
            
            Text("%")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color(UIColor(named:"PrimaryViolet")!))
            .padding(.leading, -9.0)
            
            Text("RIGHT")
            .font(.largeTitle)
          
            .foregroundColor(Color(UIColor(named:"PrimaryViolet")!))
        }
        .frame(width: 380, height: 90)
        
        .cornerRadius(10)
    }
}

struct StatsFinalSucc_Previews: PreviewProvider {
    static var previews: some View {
        StatsFinalSucc(succes: "60")
    }
}
