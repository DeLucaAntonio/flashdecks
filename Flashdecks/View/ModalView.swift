//
//  ModalView.swift
//  Flashdecks
//
//  Created by felice di palma on 18/11/21.
//

import SwiftUI

//BUG -> Quando si scrive nel campo descrizione una descrizione lunga la tastiera sta in mezzo e copre quello che stai scrivendo.

//KEYBOARD DISMISS TEXTFIELD
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



struct ModalView: View {
    
    @EnvironmentObject var useFlashdecks: UseFlashdecks
  //  @StateObject var useFlashdecks = UseFlashdecks()
    
    @State var nameDeck: String = ""
    @State var descriptionDeck: String = ""
    @Binding var modalViewActive: Bool
    
    //Flag per il bottone create
    @State var isTermPresented = true
    @State var isDefinitonPresented = true
    
    //DISMISS KEYBOARD VAR
    @FocusState private var nameIsFocused: Bool
    
    var width: CGFloat
    
    //let deck: Flashdeck
   

    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .ignoresSafeArea()
                .opacity(0.8)
            //.shadow(radius: 15)
                .shadow(color: .black, radius: 10, y: 5)
            VStack {
                VStack(alignment:.leading) {
                    
                    HStack {
                        Button {
                            withAnimation(.easeIn(duration: 0.3)) {
                                modalViewActive.toggle()
                            }
                        } label: {
                            Text("Cancel")
                                .fontWeight(.regular)
                                .foregroundColor(Color(UIColor(named:"NavigationColor")!))
                            
                        }
                        Spacer()
                        Text("Create a new deck")
                            .fontWeight(.semibold)
                        Spacer()
                        Button {
                            withAnimation {
                                //STO IF ELSE CI SERVE VERAMENTE???
                                if(nameDeck == "" || descriptionDeck == ""){
                                 //
                                }else{
                                    let result = useFlashdecks.createDeck(name: nameDeck, description: descriptionDeck)
                                    
                                    if(result){
                                        
                                        modalViewActive.toggle()
                                    }
                                }
                                
                            }
                        } label: {
                          //  NavigationLink(destination: FlashcardList(), label:   {
                            Text("Create")
                                .fontWeight(.semibold)
                         //   })
                        }
                        .environmentObject(useFlashdecks)
                        .disabled(isDefinitonPresented||isTermPresented)
                    }
                   
                    .padding(.top, -85)
                    
                    Text("DeckTitle")
                        .fontWeight(.bold)
                    TextField("DeckTitle", text: $nameDeck){  UIApplication.shared.endEditing()}
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .opacity(1)
                             //   .shadow(radius: 7.5)
                        )
                        .onChange(of: nameDeck, perform: { newterm in
                            if newterm != nil {
                                isTermPresented = false
                            } else {
                                isTermPresented = true
                            }
                        })
                    
                    
                    Text("Description")
                        .fontWeight(.bold)
                       
                    TextEditor(text: $descriptionDeck)
                        .multilineTextAlignment(.leading)
                        .frame(height:250)
                        .focused($nameIsFocused)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .opacity(1)
                             //   .shadow(radius: 7.5)
                        )
                        .onChange(of: descriptionDeck, perform: { newdefinition in
                           
                            if newdefinition != nil {
                                isDefinitonPresented = false
                            } else {
                                isDefinitonPresented = true
                            }
                        })
                        
                }
                .frame(height: width * 1.45)
                .padding(24)
                Spacer()
            }
        }
        
        .offset(y: 100)
        
        //ROBA PER DISMISSARE LA KEYBOARD QUANDO SI TAPPA FUORI DAL TEXTEDITOR
        .onTapGesture {
                nameIsFocused=false
            }
        
    }
    
}


struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
