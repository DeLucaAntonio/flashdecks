//
//  ContentView.swift
//  Flashdecks
//
//  Created by Antonio on 12/11/21.
//

import SwiftUI


struct Home: View {
    
    @StateObject var useFlashdecks = UseFlashdecks()
    
    @State var ore: String = "1"
    @State var minuti: String = "30"
    @State var secondi: String = "20"
    @State var successo: String = "70"
    @State var sessionComplete: String = "26"
    // @State var showSheet: Bool = false
    //  @State var isPresentingAddModal: Bool = false
    
    
    @State var modalViewActive: Bool = false
    @State var offset = CGSize.zero
    
    
    var body: some View {
        
        NavigationView{
            
            GeometryReader { bounds in
                VStack(alignment: .leading) {
                    
                    HStack() {
                        
                        Text("Flashdecks")
                            .fontWeight(.bold)
                            .font(.largeTitle)
                            .padding(.top, 10.0)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                modalViewActive.toggle()
                            }
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.headline)
                        }
                        
                        
                    }.padding(.top, -40)
                    
                    
                    
                    
                    Spacer()
                    
                    
                    
                    HStack{
                        Text("Statistics")
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(width: 174, alignment: .topLeading)
                            .lineSpacing(28)
                        
                        
                        Spacer()
                        
                        
                    }
                    .padding(.top, 0.0)
                    
                    
                    
                    HStack {
                        
                        AverageDuration(hours: ore, minutes: minuti, seconds: secondi)
                        Spacer()
                        SessionCompleted(sessionCompleted: sessionComplete)
                        
                    }
                    
                    .padding()
                    
                    TotalSuccess(succes: successo)
                        .padding(.top, -15.0)
                    
                    HStack{
                        Text("Recent decks")
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(width: 174, alignment: .topLeading)
                            .lineSpacing(28)
                        
                        Text("See All →")
                            .fontWeight(.bold)
                            .font(.callout)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 174, alignment: .trailing)
                            .lineSpacing(28)
                        
                        
                    }
                    .padding()
                    
                    visualDeck()
                    
                }.padding()
                    .blur(radius: modalViewActive ? 10 : 0)
                    .scaleEffect(modalViewActive ? 0.95 : 1)
                
                
                if modalViewActive {
                    ZStack {
                        ModalView(useFlashdeck: useFlashdecks, modalViewActive: $modalViewActive, width: bounds.size.width )
                    }
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom))
                    .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.offset.height = gesture.translation.height
                                
                            }
                            .onEnded { _ in
                                if self.offset.height > bounds.size.height / 2 {
                                    withAnimation {
                                        modalViewActive.toggle()
                                    }
                                    self.offset = .zero
                                } else {
                                    self.offset = .zero
                                }
                            }
                    )
                }
                
            }
            
            
        }.navigationBarHidden(true)
        
    }
    
    
    private func visualDeck() -> some View{
        
        ScrollView(.vertical, showsIndicators: true) {
            
            ForEach(useFlashdecks.deckList) { deck in
                DeckRow(deck: deck)
            }
            
        }
        
    }
}




//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home(collectionDecks: Flashdeck.)
//    }
//}
