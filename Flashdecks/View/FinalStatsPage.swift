//
//  FinalStats.swift
//  Flashdecks
//
//  Created by felice di palma on 18/11/21.
//

import SwiftUI

struct FinalStatsPage: View {
    
    @State var succ: String = "60"
    
    //passare le variabili di stato per le statistiche
    @State var buttonPressed: Bool = false
    @State var playAgain : Bool = false
    
    var body: some View {
        
        
        ZStack{
            
            //Background
            Color(UIColor(named:"PrimaryViolet")!).ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("CONGRATS")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .lineSpacing(24)
                    .foregroundColor(.white)
                
                Text("You’ve finished this session")
                    .fontWeight(.bold)
                    .font(.title3)
                    .lineSpacing(24)
                    .foregroundColor(.white)
              
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 285, height: 63)
                    
                    Text("60% Right")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .lineSpacing(24)
                        .foregroundColor(Color(UIColor(named:"StatsColor")!))
                }
                
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.38, green: 0.38, blue: 0.85))
                            .frame(width: 285, height: 63)
                        
                        Text("40% Wrong")
                            .fontWeight(.medium)
                            .font(.title)
                 //.frame(width: 205, alignment: .topLeading)
                           // .lineSpacing(24)
                            //.padding(.bottom,20)
                            .foregroundColor(.white)
                      
                        
                    }
                    
//                    ZStack{
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color(red: 0.38, green: 0.38, blue: 0.85))
//                            .frame(width: 134, height: 63)
//                        Text("40%")
//                            .fontWeight(.medium)
//                            .font(.title3)
//                           // .frame( alignment: .topLeading)
//                            .lineSpacing(24)
//                            .padding(.trailing, 80.0)
//                            .padding(.bottom,20)
//                            .foregroundColor(.white)
//                        Text("Skipped")
//                            .fontWeight(.medium)
//                            .font(.title3)
//                            .frame( alignment: .topLeading)
//                            .lineSpacing(24)
//                            .padding([.leading, .bottom], -50.0)
//                            .foregroundColor(.white)
//
//
//                    }
                    
                }
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(red: 0.29, green: 0.28, blue: 0.83))
                        .frame(width: 284, height: 67)
                    
                    Text("1:30:02")
                        .fontWeight(.medium)
                        .font(.title)
                        .lineSpacing(24)
                        .foregroundColor(.white)
                    
                    
                }
                
                Spacer()
                VStack{
                    Button(action: {
                        playAgain.toggle()
                    }) {
                        ZStack{
                            
                            Rectangle()
                                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.white)
                                .frame(width: 155, height: 55)
                                .shadow(color: Color( "NavigationColor" ), radius: 8,x:5, y: 3)
                            
                            
                            
                            Text("Play Again ")
                                .fontWeight(.bold)
                                .foregroundColor(Color(UIColor(named: "PrimaryViolet")!))
                                
                        }
                        
                    }
                    
                    Button(action: {
                        buttonPressed.toggle()
                    }) {
                        
                        Text("Done")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            
                        
                    }
                }
                
                
                Spacer()
                
            }
            
            
            
        }
        .navigate(to: Home(), when: $buttonPressed)
        .navigate(to: GameStartScreenView(), when: $playAgain)
        
        
    }
    
    
    
}

//struct FinalStatsPage_Previews: PreviewProvider {
//    static var previews: some View {
//        FinalStatsPage()
//    }
//}



extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
