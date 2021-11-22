//
//  EditFlashcardModal.swift
//  Flashdecks
//
//  Created by Ivan Voloshchuk on 20/11/21.
//

import SwiftUI


struct EditFlashcardModal: View {
    
    //STRUTTURE PER I CAMPI PLACEHOLDER DA CANCELLARE
    /*   @State var term: String = ""
     @State var definition: String = ""
     
     @State var keywords: [String] = ["","",""]*/
    

    @State private var newCard = Flashcard(id: String(Int(NSDate().timeIntervalSince1970)),
        name: "",keywords: ["","",""], definition: ""
    )
    
//
    @StateObject var useFlashdecks = UseFlashdecks()
//
//    @State var newCard : Flashcard
    
    //VAR BINDING PER IL BOTTONE CANCEL
    @Binding var isModalPresented: Bool
    
    //Var booleane per il controllo del riempimento dei campi termine e descrizione
    @State private var isTermPresented = true
    @State private var isDefinitonPresented = true
    
    @State var deckId : String
    
    
    
    var body: some View {
        NavigationView{
            
            //CONTENITORE DEI CAMPI
            VStack(alignment: .leading){
                
                Text("Content")
                    .fontWeight(.bold)
                TextField(
                    "Term",
                    text: $newCard.name
                    
                ).onChange(of: newCard.name, perform: { newterm in
                    if newterm != "" {
                        isTermPresented = false
                    } else {
                        isTermPresented = true
                    }
                    
                    
                })
               
                Divider()
                Text("Definition")
                    .fontWeight(.bold)
                TextEditor(
                    
                    text: $newCard.definition
                    
                )   .frame(height: 150)
                    .multilineTextAlignment(.leading)
                    .onChange(of: newCard.definition, perform: { newdefinition in
                        if newdefinition != "" {
                            isDefinitonPresented = false
                        } else {
                            isDefinitonPresented = true
                        }
                        
                        
                    })
                
                Divider()
                Text("Keywords")
                    .fontWeight(.bold)
                
                VStack{
                    TextField(
                        "Optional",
                        text: $newCard.keywords[0]
                    )
                    Divider()
                    
                    TextField(
                        "Optional",
                        text: $newCard.keywords[1]
                    )
                    Divider()
                    TextField(
                        "Optional",
                        text: $newCard.keywords[2]
                    )
                    Divider()
                }
                Spacer()
                 
            }.padding()
                .navigationBarItems(trailing: Button("Save",action: {
                  //ON CLICK SAVE ADDA LA NUOVA FLASHCARD
                    let result = useFlashdecks.createCard(newFlashcard: newCard, deckId: deckId)
                    print(result)
                    isModalPresented.toggle()
                    
                }) .disabled(isDefinitonPresented||isTermPresented) //Il save è disabilitato finchè non diventano entrambi veri
                                    //PROBLEMA CON I COLORI       .foregroundColor(Color(UIColor(named: "NavigationColor")!))
                                    
                )
            
                .navigationBarItems(leading: Button("Cancel",action: {
                    isModalPresented.toggle()
                    
                }).foregroundColor(Color(UIColor(named: "NavigationColor")!))
                )
            
                .navigationBarTitle("New Flashcard", displayMode: .inline)
        }
    }
}

//struct EditFlashcard_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

