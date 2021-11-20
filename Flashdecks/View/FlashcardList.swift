//
//  FlashcardList.swift
//  Flashdecks
//
//  Created by Ivan Voloshchuk on 20/11/21.
//

import SwiftUI


struct FlashcardList: View {
    
    // @StateObject private var viewModel = FlashcardListViewModel()
    
    
    //Var per capire se attivare la modal
    @State var isPresentingAddModel = false
    
    //VAR PLACEHOLDER
//    let flashcardsList: [Flashcard] = [Flashcard(id: "23", name: "Mma", description: "Desvrip"), Flashcard(id: "1212", name: "Nome", description: "Descrizione 2"),Flashcard(id: "12d12", name: "Tsre", description: "Descrizione 2"),Flashcard(id: "12sd12", name: "Tsre", description: "Descrizione 2"),Flashcard(id: "12asd12", name: "sTre", description: "Descrizione 2"),Flashcard(id: "12aad12", name: "Tre", description: "Descrizione 2"),Flashcard(id: "12s12", name: "Trase", description: "Descrizione 2")]
    
    //VAR PER LA GRID
    let columns = Array(repeating: GridItem(.flexible(),spacing: 5), count: 2)
    
    //VAR PLACEHOLDER FINALE
    //@StateObject var useFlashdecks = UseFlashdecks()
  //  let deck: Flashdeck
    
    @EnvironmentObject var useFlashdeck: UseFlashdecks
    
    var body: some View {
        
        VStack{
            
            //TITLE AND DESCRIPTION OF THE DECK
            Text("deck.description")
                .fontWeight(.regular)
                .multilineTextAlignment(.leading)
            
            ScrollView{
                
                //ADD NEW FLASHCARD COMPONENT
                ZStack{
                    Rectangle()
                        .frame(width: 320.0, height: 100.0)
                        .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color(UIColor(named: "GreyOpacity")!))
                        .shadow(color:.gray.opacity(0.5),radius: 5,x:0,y:4)
                    Text("+")
                        .font(.system(size: 60))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }.padding(.bottom,20)
                .onTapGesture {
                    self.isPresentingAddModel.toggle()
                }
                
                
                //STAMPA TUTTE LE FLASHCARD
                /*   LazyVGrid(columns: columns, spacing: 10,content: {
                        ForEach(deck.flashcards){index,flashcards in
                           
                        ZStack{
                            Rectangle()
                                .frame(width: 145.0, height: 155.0)
                                .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(UIColor(named: "PrimaryViolet")!))
                                .shadow(color:.gray.opacity(0.5),radius: 5,x:0,y:4)
                            Text(deck.flashcards[index].name)
                                .font(.system(size: 26))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        
                        }
                        
                    }).padding(.horizontal) */
                    
                }
                
            
                              
            
            
        }
        
        // PROPRIETIES OF NAVIGATION
        .navigationTitle("Calculus 1")
        .toolbar{
            Button("Edit"){
                //AZIONE
            }
        }.environmentObject(useFlashdeck)
        .sheet(isPresented: $isPresentingAddModel,content:{EditFlashcardModal(isModalPresented: self.$isPresentingAddModel)})
    }
    
}

//struct FlashcardList_Previews: PreviewProvider {
//    static var previews: some View {
//        FlashcardList()
//    }
//}
