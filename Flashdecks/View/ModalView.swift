//
//  ModalView.swift
//  Flashdecks
//
//  Created by felice di palma on 18/11/21.
//

import SwiftUI



struct ModalView: View {
    
    @ObservedObject var useFlashdeck: UseFlashdecks
    
    @State var nameDeck: String = ""
    @State var descriptionDeck: String = ""
    @Binding var modalViewActive: Bool
    
    
    var width: CGFloat
    
    
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .ignoresSafeArea()
                .opacity(0.6)
            //.shadow(radius: 15)
            //.shadow(color: .black, radius: 10, y: 5)
            VStack {
                VStack(alignment:.leading) {
                    
                    HStack {
                        Button {
                            withAnimation(.easeIn(duration: 0.3)) {
                                modalViewActive.toggle()
                            }
                        } label: {
                            Text("Cancel")
                            
                                .foregroundColor(Color(UIColor(named:"NavigationColor")!))
                            
                        }
                        Spacer()
                        Button {
                            withAnimation {
                                if(nameDeck == "" || descriptionDeck == ""){
                                    
                                }else{
                                    let result = useFlashdeck.createDeck(name: nameDeck, description: descriptionDeck)
                                    
                                    if(result){
                                        modalViewActive.toggle()
                                    }
                                }
                                
                            }
                        } label: {
                            Text("Create")
                                .bold()
                                .foregroundColor(Color(UIColor(named:"NavigationColor")!))
                            
                        }
                    }
                    .padding(.top, -100)
                    
                    Text("DeckTitle")
                        .fontWeight(.bold)
                    TextField("DeckTitle", text: $nameDeck)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .opacity(0.5)
                                .shadow(radius: 7.5)
                        )
                    
                    
                    
                    Text("Description")
                        .fontWeight(.bold)
                    TextEditor(
                        text: $descriptionDeck)
                        .multilineTextAlignment(.leading)
                        .frame(height:250)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .opacity(0.5)
                                .shadow(radius: 7.5)
                        )
                    
                }
                .frame(height: width * 1.45)
                .padding(30)
                Spacer()
            }
        }
        
        .offset(y: 70)
        .background(.black.opacity(0.4))
    }
    
}


struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
