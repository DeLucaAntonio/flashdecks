//
//  TotalSuccess.swift
//  Flashdecks
//
//  Created by felice di palma on 16/11/21.
//

import SwiftUI

struct TotalSuccess: View {
    
    let succes: String
    
    
    fileprivate func extractedFunc() -> some View {
        return Image(systemName: "arrow.up.forward.circle.fill")
            .imageScale(.large)
            .frame(width: 50, alignment: .topLeading)
            .scaleEffect(1.6)
            .foregroundColor(Color(UIColor(named: "ColorHomeStats")!))
    }
    
    var body: some View {
        HStack(spacing: 19.06) {
            extractedFunc()

            Text("Total \nSuccess")
            .font(.subheadline)
            .offset(x: -25)
            .scaleEffect(1.2)
            .frame(width: 60, alignment: .topLeading)
            .foregroundColor(Color(UIColor(named: "ColorHomeStats")!))
            .padding(.trailing,40)
          

            Text("\(succes)%")
            .fontWeight(.bold)
            .font(.largeTitle)
            .multilineTextAlignment(.trailing)
            .frame(width: 130, alignment: .center)
            .scaleEffect(1.2, anchor: .center)
            .foregroundColor(.white)
           
            
           /* Text("%")
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(width:30, alignment: .leading)
            .scaleEffect(1.7)
            .foregroundColor(.white) */
        }
        //.padding(.leading, 16)
        //.padding(.trailing, 30)
        //.padding(.top, 25)
        //.padding(.bottom, 24)
        .frame(width: 380, height: 90)
        .background(Color(red: 0.38, green: 0.37, blue: 0.84))
        .cornerRadius(10)
       
    }
}

#if DEBUG
struct TotalSuccess_Previews: PreviewProvider {
    static var previews: some View {
        TotalSuccess(succes: "70")
    }
}
#endif
