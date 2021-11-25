//
//  SessionCompleted.swift
//  Flashdecks
//
//  Created by felice di palma on 16/11/21.
//

import SwiftUI

struct SessionCompleted: View {
    let sessionCompleted: String
    
    var body: some View {
        ZStack{
            Text("Sessions \nCompleted")
            .font(.subheadline)
            .frame(width: 76.23, alignment: .topLeading)
            .lineSpacing(1)
            .offset(x: 6.23, y: -16.50)
            .foregroundColor(Color(UIColor(named: "ColorHomeStats")!))

            Image(systemName: "checkmark.circle.fill")
                .imageScale(.small)
            .font(.largeTitle)
            .frame(width: 50.25, alignment: .topLeading)
            .lineSpacing(15.50)
            .offset(x: -40, y: -18)
            .foregroundColor(Color(UIColor(named: "ColorHomeStats")!))
            
        
            Text("8")
            .fontWeight(.bold)
            .font(.largeTitle)
            .lineSpacing(15.50)
            .offset(x: -40, y: 25)
            .foregroundColor(.white)
        }
        .padding(.leading, 9)
        .padding(.trailing, 10)
        .padding(.top, 14)
        .padding(.bottom, 11)
        .frame(width: 160, height: 90)
        .background(Color(red: 0.38, green: 0.37, blue: 0.84))
        .cornerRadius(10)
        .frame(width: 135.41, height: 90)
              
    }
    
}

#if DEBUG
struct SessionCompleted_Previews: PreviewProvider {
    static var previews: some View {
        SessionCompleted(sessionCompleted: "29")
    }
}
#endif
