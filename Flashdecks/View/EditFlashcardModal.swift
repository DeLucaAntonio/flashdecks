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
    
    //Roba del pattern MVVM
/*    @ObservedObject var viewModel: FlashcardListViewModel
    @State private var newFlashcard = Flashcard(
        term: "", definition: "", keyword: ["","",""]
    )
    */
    
    
    @State var newCard = Flashcard(id: "", name: "",Keywords: [""], definition: "")
    let useFlashdecks = UseFlashdecks()
    
    
    //VAR BINDING PER IL BOTTONE CANCEL
    @Binding var isModalPresented: Bool
    
    //Var booleane per il controllo del riempimento dei campi termine e descrizione
    @State private var isTermPresented = true
    @State private var isDefinitonPresented = true
    
    //PROVA CON I DATI VERI
   // @ObservedObject var useFlashdeck: UseFlashdecks
    
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
                /*
                Divider()
                Text("Keywords")
                    .fontWeight(.bold)
                
                VStack{
                    TextField(
                        "Optional",
                        text: $newFlashcard.keyword[0]
                    )
                    Divider()
                    
                    TextField(
                        "Optional",
                        text: $newFlashcard.keyword[1]
                    )
                    Divider()
                    TextField(
                        "Optional",
                        text: $newFlashcard.keyword[2]
                    )
                    Divider()
                }
                Spacer()
                 */
            }.padding()
                .navigationBarItems(trailing: Button("Save",action: {
                  //ON CLICK SAVE ADDA LA NUOVA FLASHCARD
                   // useFlashdecks.createCard(newFlashcard: newCard, deckId: "01")
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
