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
    
    //VAR PER LA GRID
    let columns = Array(repeating: GridItem(.flexible(),spacing: 5), count: 2)
    
    //VAR PLACEHOLDER FINALE
    //@StateObject var useFlashdecks = UseFlashdecks()
    //  let deck: Flashdeck
    
    //VAR PER L'ALLERT
    @State var showingAlert : Bool = false
    
    //VAR PRESE DALLA VIEW TOTAL DECK
    //@State var name : String
  //  @State var description:String
    
    //VAR PER TORNARE ALLA ROOT ON DELETE
    @Environment(\.presentationMode) var presentationMode
    
    //ENVIRONMENT
    @EnvironmentObject var useFlashdecks: UseFlashdecks
    
    @State var deck: Flashdeck
    
    
    var body: some View {
        
        VStack{
            //TITLE AND DESCRIPTION OF THE DECK
            Text(deck.description)
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
                
                LazyVGrid(columns: columns, spacing: 10,content: {
                    ForEach(deck.flashcards, id: \.self){card in  //COME FACCIO A CAPIRE QUANTE CARTE HO
                        
                        ZStack{
                            Rectangle()
                                .frame(width: 145.0, height: 155.0)
                                .cornerRadius(/*@START_MENU_TOKEN@*/15.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(Color(UIColor(named: "PrimaryViolet")!))
                                .shadow(color:.gray.opacity(0.5),radius: 5,x:0,y:4)
                            Text(card.name) //VA OUT OF RANGE
                                .font(.system(size: 26))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        
                    }
                    
                }).padding(.horizontal)
                
            }
            
            
            
            
            
        }.navigationTitle(deck.name)
        
        
        // PROPRIETIES OF NAVIGATION
        //.navigationTitle("Calculus 1")
            .toolbar{
                Button("Delete deck"){
                    showingAlert=true
                }.alert(isPresented:$showingAlert) {
                    Alert(
                        title: Text("Are you sure you want to delete this deck?"),
                        message: Text("There is no undo"),
                        primaryButton: .destructive(Text("Delete")) {
                            
                            //torna alla view di prima on delete
                            self.presentationMode.wrappedValue.dismiss()
                            print("Deleting...")
                            
                        },
                        secondaryButton: .cancel()
                    )
                }
            }.environmentObject(useFlashdecks)
            .sheet(isPresented: $isPresentingAddModel,content:{EditFlashcardModal(isModalPresented: self.$isPresentingAddModel ,deckId: deck.id)})
    }
    
}

//struct FlashcardList_Previews: PreviewProvider {
//    static var previews: some View {
//        FlashcardList()
//    }
//}
