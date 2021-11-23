//
//  ContentView.swift
//  Flashdecks
//
//  Created by Antonio on 12/11/21.
//

import SwiftUI


struct Home: View {
    
    @StateObject var useFlashdecks = UseFlashdecks()
    @StateObject var useStatistics = UseStatistics()

    @State var sessionComplete: String = "26"
    // @State var showSheet: Bool = false
    //  @State var isPresentingAddModal: Bool = false
    
    
    @State var modalViewActive: Bool = false
    @State var offset = CGSize.zero
    
    
    var body: some View {
        
       NavigationView{ //BUGGED Perchè mi showa nella modal il titolo e il pulsante non blurrati
            
            GeometryReader { bounds in
                VStack(alignment: .leading) {
                    
                   /*
                    HStack{
                        Text("Statistics")
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(width: 174, alignment: .topLeading)
                            .lineSpacing(28)
                        Spacer()
                        
                        
                    }
                    .padding(.top, 0.0)
                    */
                    
                    HStack {
                        
                        AverageDuration(hours: useStatistics.avergeHours, minutes: useStatistics.avergeMinutes, seconds: useStatistics.avergeSeconds)
                        Spacer()
                        SessionCompleted(sessionCompleted: sessionComplete)
                        
                    }
                    
                    .padding()
                    
                    TotalSuccess(succes: String(useStatistics.globalStatistics.totalSuccess))
                        .padding(.top, -15.0)
                    
                    HStack{
                        Text("Recent decks")
                            .fontWeight(.bold)
                            .font(.title2)
                            .frame(width: 174, alignment: .topLeading)
                            .lineSpacing(28)
                        Spacer()
                        
                        
                        NavigationLink(destination: TotalDeck(useFlashdecks: useFlashdecks), label:   {
                            
                            Text("See All →")
                                .fontWeight(.bold)
                                .font(.callout)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 174, alignment: .trailing)
                                .lineSpacing(28)
                            
                        })            .isDetailLink(false)

                   
                        
                        
                    }
                   .padding(.top,10)
                    
                    visualDeck()
                    
                }.padding()
                    .scaleEffect(modalViewActive ? 0.95 : 1)
                    .background(.black.opacity(modalViewActive ? 0.3: 0))
                    .blur(radius: modalViewActive ? 8 : 0)
                   
                    
                
                if modalViewActive {
                    ZStack {
                        ModalView(useFlashdecks: useFlashdecks, modalViewActive: $modalViewActive, width: bounds.size.width )
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
                
            } .navigationTitle("Flashdecks")
               .navigationBarTitleDisplayMode(.large)
               .navigationBarItems(trailing:
                                    Button {
                                        withAnimation {
                                            modalViewActive.toggle()
                                        }
                                        
                                    } label: {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .frame(width: 25.0, height: 25.0)
                                            
                                    })
            
       }.navigationBarHidden(true)
            .environmentObject(useFlashdecks)
           
        
        
    }
    
    
    private func visualDeck() -> some View{
        
        ScrollView(.vertical, showsIndicators: false) {
            
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
