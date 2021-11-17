//
//  FlippedCard.swift
//  Flashdecks
//
//  Created by felice di palma on 15/11/21.
//

import SwiftUI

struct FlippedCard: View {
    
       @State private var selection: String? = nil
       @State var progressValue: Float = 0.0
       @State var countCards:Int=0
       
       let totalCards=10
    
    var body: some View {
        NavigationView{
            VStack{
            
                ProgressBar(value: $progressValue).frame(width: 300,height: 20)
                               
                               Text("\(countCards)/\(totalCards)")
                                   .font(.body)
                                   .fontWeight(.bold)
                                   .padding(.trailing, 250.0)
                               
                               Spacer()
                
                ZStack{
                    
                    
                            Rectangle()
                                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(UIColor(named: "PrimaryViolet")!))
                                .frame(width: 265, height: 380)
                    Text("Object")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.bottom, 300.0)
                                  
                    Image(systemName: "goforward")
                        .resizable()
                        .frame(width: 30, height: 40)
                        .onTapGesture(perform: {
                            countCards+=1})
                   
                  
                    
                 
                    
                 
                  
                }
                Spacer()
                
                HStack{
                    Spacer()
                            Button(action: {
                                    self.resetProgressBar()
                                    countCards=0
                                }) {
                                    ZStack{
                                               
                                        Rectangle()
                                        .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(Color(UIColor(named: "GreyProgressBar")!))
                                        .frame(width: 105, height: 55)
                                               
                                        Text("Wrong")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    }
                                }
                         Spacer()
                    
                    
                        Button(action: {
                            self.startProgressBar()
                                if(countCards<totalCards){
                                    countCards+=1
                                }
                            }) {
                                ZStack{
                                        
                                    Rectangle()
                                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(Color(UIColor(named: "PrimaryViolet")!))
                                    .frame(width: 105, height: 55)
                                        
                                    Text("Right")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                }
                                    
                            }
                                Spacer()
                }
                Spacer()
            
            }
            .navigationBarTitle("Objected Orientation")
            
           .navigationBarItems(trailing:
                                    NavigationLink("Quit", destination: Home())
                                    
            )
            .navigationBarTitleDisplayMode(.inline)
           
           
            
            
        }
    }
    func startProgressBar() {
        
        self.progressValue += 0.1
        
    }
    
    func resetProgressBar() {
        self.progressValue = 0.0
    }
}

struct FlippedCard_Previews: PreviewProvider {
    static var previews: some View {
        FlippedCard()
    }
}

struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor(named: "GreyProgressBar")!))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor(named:"PrimaryViolet")!))
                    .animation(.easeIn)
            }.cornerRadius(45.0)
        }
    }
}
