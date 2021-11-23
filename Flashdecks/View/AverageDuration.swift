//
//  AverageDuration.swift
//  Flashdecks
//
//  Created by felice di palma on 16/11/21.
//

import SwiftUI

struct AverageDuration: View {
    let hours: String
    let minutes: String
    let seconds: String
    
    fileprivate func extractedFunc() -> some View {
        return ZStack {
            Text("Average \nDuration")
                .font(.subheadline)
                .frame(width: 79.56, alignment: .topLeading)
                .lineSpacing(1)
                .offset(x: 6.23, y: -16.50)
                .foregroundColor(Color(UIColor(named: "ColorHomeStats")!))
            
            Text(hours)
                .fontWeight(.semibold)
                .font(.largeTitle)
                .frame(width: 23.73, alignment: .topLeading)
                .lineSpacing(15.50)
                .offset(x: -66.82, y: 26)
                .foregroundColor(.white)
            
            Text(minutes)
                .fontWeight(.semibold)
                .font(.largeTitle)
                .frame(width: 60.02, alignment: .topLeading)
                .lineSpacing(15.50)
                .offset(x: -9.14, y: 27)
                .foregroundColor(.white)
            
            Text(seconds)
                .fontWeight(.semibold)
                .font(.largeTitle)
                .frame(width: 60.02, alignment: .topLeading)
                .lineSpacing(15.50)
                .offset(x: 53.96, y: 27)
                .foregroundColor(.white)
            
            Image(systemName: "clock.fill")
                .imageScale(.small)
                .font(.largeTitle)
                .frame(width: 50.25, alignment: .topLeading)
                .lineSpacing(15.50)
                .offset(x: -52.56, y: -16)
                .foregroundColor(Color(UIColor(named: "ColorHomeStats")!))
            
            
            Text("h")
                .font(.title3)
                .frame(width: 15.35, alignment: .topLeading)
                .lineSpacing(15.50)
                .offset(x: -48.33, y: 30)
                .foregroundColor(Color(UIColor(named: "ColorHomeStats")!))
            
            Text("m")
                .font(.title3)
                .frame(width: 23.73, alignment: .topLeading)
                .lineSpacing(15.50)
                .offset(x: 14.52, y: 30)
                .foregroundColor(Color(UIColor(named: "ColorHomeStats")!))
            
            Text("s")
                .font(.title3)
                .frame(width: 23.73, alignment: .topLeading)
                .lineSpacing(15.50)
                .offset(x: 78.62, y: 30)
                .foregroundColor(Color(UIColor(named: "ColorHomeStats")!))
        }
        .frame(width: 210, height: 90)
        .background(Color(red: 0.38, green: 0.37, blue: 0.84))
        .cornerRadius(10)
        .frame(width: 181.45, height: 90)
    }
    
    var body: some View {
        
        extractedFunc()
        
        
    }
}


