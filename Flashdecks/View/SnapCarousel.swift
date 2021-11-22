//
//  SnapCarousel.swift
//  Flashdecks
//
//  Created by Francesco Iaccarino on 19/11/21.
//

import SwiftUI


struct ProgressBar: View {
    
    @EnvironmentObject var UIState: UIStateModel
    
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    Rectangle().frame(width: min(CGFloat(self.UIState.progressValue)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(UIColor.systemBlue))
                        .animation(.linear)
                }.cornerRadius(45.0)
            }
        }
}

struct SnapCarousel: View
{
    //@EnvironmentObject var UIState: UIStateModel
    var Stats: SessionStats
    
    var UIState: UIStateModel
    @State var flipped: Bool = false
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    
    @State var buttonDone: Bool = false
    @State var timerIsPaused: Bool = true
    @State var touched: Bool = false
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    @State var cardList: [Flashcard] = [Flashcard(id: "020", name: "Object", keywords: ["class", "method", "instance"], definition: "Objects are the things you think about first in designing a program and they are also the units of code that are eventually derived from the process. Each object is an instance of a particular class or subclass with the class's own methods or procedures and data variables."), Flashcard(id: "030", name: "Bestemmioni", keywords: ["KTM", "KTM+", "KTM++"], definition: "le classi sono molto belle"), Flashcard(id: "040", name: "boh", keywords: ["ch aggia scrivr", "a me m piac a nutell", "o bacin"], definition: "GELooooo MRIOOOOOOOS")]
   
    @State var timer: Timer? = nil
    
    
    
    
    var body: some View
    {
        let spacing:            CGFloat = 1
        let widthOfHiddenCards: CGFloat = 32    // UIScreen.main.bounds.width - 10
        let cardHeight:         CGFloat = 279
        self.UIState.totalCards = cardList.count
        self.Stats.cardStats.time = Int(NSDate().timeIntervalSince1970)
        
        

        return  Canvas
                {
                    
                    //
                    // TODO: find a way to avoid passing same arguments to Carousel and Item
                    //
                    NavigationView{
                        
                        
                        VStack{
                            ProgressBar().frame(width: 330,height: 20).environmentObject(self.UIState)
                            
                            
                            HStack(spacing:190){
                                Text(String(self.UIState.cardsDone) + "/" + String(cardList.count)).font(.system(size: 18, weight: .regular))
                                
                                HStack {
                                //image 1
                                    Image(systemName: "timer")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.55, blue: 1, alpha: 1)))
                                    .font(Font.title.weight(.semibold))
                                    
                                //03:20 s
                                    Text(String(format:"%02i:%02i:%02i", hours, minutes, seconds)).font(.system(size: 18, weight: .regular)).tracking(0.35)
                                }
                                
                            }.frame(height: 40)
                            
                            Spacer()
                            Carousel( numberOfItems: CGFloat( cardList.count ), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards )
                            {
                                ForEach( cardList, id: \.self.id ) { card in
                                    Item( _id:                  Int(card.id)!,
                                          spacing:              spacing,
                                          widthOfHiddenCards:   widthOfHiddenCards,
                                          cardHeight:           cardHeight ,
                                          card: card)
                                    {
                                        
                                    }
                                    
                                    .cornerRadius( 8 )
                                    .shadow( color: Color( "shadow1" ), radius: 4, x: 0, y: 4 )
                                    .transition( AnyTransition.slide )
                                    .animation( .spring() )
                                    
                                }
                            }
                            .environmentObject(self.UIState )
                            .environmentObject(self.Stats)
                            Spacer()
                            
                            HStack{
                                Button {
                                    withAnimation {
                                        self.UIState.buttonsShow = false
                                        self.UIState.activeCard+=1
                                        self.UIState.cardsDone += 1
                                        self.Stats.wrong += 1
                                        self.UIState.progressValue = self.UIState.progressValue +
                                        Float((1.0/Float(self.UIState.totalCards)))
                                        self.Stats.cardStats.result = false
                                        self.Stats.cardStats.time = Int(NSDate().timeIntervalSince1970) - self.Stats.cardStats.time
                                        self.Stats.stats.append(self.Stats.cardStats)
                                    }
                                } label: {
                                        Text("Wrong").frame(maxWidth: 107)
                                        .padding()
                                        .foregroundColor(.black)
                                }.background(Color(#colorLiteral(red: 0.8873699307441711, green: 0.8873699307441711, blue: 0.8873699307441711, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                
                                
                                Button {
                                    withAnimation {
                                        self.UIState.buttonsShow = false
                                        self.UIState.activeCard += 1
                                        self.UIState.cardsDone += 1
                                        self.Stats.right += 1
                                        self.UIState.progressValue = self.UIState.progressValue +
                                        Float((1.0/Float(self.UIState.totalCards)))
                                        self.Stats.cardStats.result = true
                                        self.Stats.cardStats.time = Int(NSDate().timeIntervalSince1970) - self.Stats.cardStats.time
                                        self.Stats.stats.append(self.Stats.cardStats)
                                    }
                                    
                                } label: {
                                        Text("Right").frame(maxWidth: 107)
                                        .padding()
                                        .foregroundColor(.white)
                                }.background(Color(#colorLiteral(red: 0.5411764979362488, green: 0.5333333611488342, blue: 0.886274516582489, alpha: 1)))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                
                            }.opacity(self.UIState.buttonsShow ? 1:0)
                                .transition(.scale)
                            Spacer()
                           
                                
                        }.navigationBarTitle("hello")
                        .navigationBarTitleDisplayMode(.inline)
                        
                        .toolbar{
                            Button("Done") {
                                print("Help tapped!")
                                //aggiungere lle statistiche
                                buttonDone.toggle()
                                //INSERIRE STATISTICHE QUI
                            }
                        }
                            
                            
                            
                    }.onAppear {
                        self.startTimer()
                    
                    
                    }.navigate(to: FinalStatsPage(), when: $buttonDone)
    }
    
   
}
    
    func startTimer(){
        timerIsPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
          if self.seconds == 59 {
            self.seconds = 0
            if self.minutes == 59 {
              self.minutes = 0
              self.hours = self.hours + 1
            } else {
              self.minutes = self.minutes + 1
            }
          } else {
            self.seconds = self.seconds + 1
          }
        }
      }
      
      func stopTimer(){
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
      }
    
    

}



struct Card: Decodable, Hashable, Identifiable
{
    var id:     Int
    var name:   String = ""
}



public class UIStateModel: ObservableObject
{
    @Published var activeCard: Int      = 0
    @Published var screenDrag: Float    = 0.0
    @Published var buttonsShow: Bool = false
    @Published var cardsDone: Int = 0
    @Published var totalCards: Int = 0
    @Published var progressValue: Float = 0.0
}

public class SessionStats: ObservableObject
{
    @Published var right: Int      = 0
    @Published var wrong: Int    = 0
    @Published var stats: [CardStatistic] = []
    @Published var previousTime: Int = 0
    
    @Published var cardStats: CardStatistic = CardStatistic(time: Int(NSDate().timeIntervalSince1970), result: false)
    
}

struct Carousel<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat //= 8
    let spacing: CGFloat //= 16
    let widthOfHiddenCards: CGFloat //= 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    let float: Float = 1
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var UIState: UIStateModel
    @EnvironmentObject var Stats: SessionStats
        
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
        
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        
    }
    
    var body: some View {
        
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing

        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)

        var calcOffset = Float(activeOffset)

        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.UIState.screenDrag = Float(currentState.translation.width)

        }.onEnded { value in
            self.UIState.screenDrag = 0
          

            if (value.translation.width < -50) {
                self.UIState.activeCard = self.UIState.activeCard + 1
                self.UIState.cardsDone += 1
                self.Stats.wrong += 1
                self.UIState.progressValue = self.UIState.progressValue +
                Float((1.0/Float(self.UIState.totalCards)))
                self.Stats.cardStats.result = false
                self.Stats.cardStats.time = Int(NSDate().timeIntervalSince1970) - self.Stats.cardStats.time
                self.Stats.stats.append(self.Stats.cardStats)
               
                
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }

//            if (value.translation.width > 50) {
//                self.UIState.activeCard = self.UIState.activeCard - 1
//                let impactMed = UIImpactFeedbackGenerator(style: .medium)
//                impactMed.impactOccurred()
//            }
        })
    }
}



struct Canvas<Content : View> : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    @EnvironmentObject var Stats: SessionStats
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}



struct Item<Content: View>: View {
    @EnvironmentObject var UIState: UIStateModel
    @EnvironmentObject var Stats: SessionStats
  
    let cardWidth: CGFloat
    let cardHeight: CGFloat

    @State var flipped: Bool = false
    @State var flashcardRotation = 0.0
    @State var contentRotation = 0.0
    var card: Flashcard
    
    var _id: Int
    var content: Content

    @inlinable public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        card: Flashcard,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = 330 //279
        self.cardHeight = 460
        self._id = _id
        self.card = card
            
    }

    var body: some View {
        ZStack {
            if flipped {
                
                ZStack {
                //Rectangle 25
                    RoundedRectangle(cornerRadius: 10)
                    .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .frame(width: 260, height: 360)

                //Objects are the things you...
                    Text(card.definition).font(.system(size: 16, weight: .light)).tracking(0.35)
                        .frame(width: 230, height: 316)
                    }
                
            
            } else {
                VStack {
                    Spacer()
                    Text(card.name).font(.system(size: 40, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).tracking(0.36)
                    Spacer()
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: 10)
                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .frame(width: 199, height: 26)
                        Text(card.keywords[0]).font(.system(size: 16, weight: .light))
                        
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .frame(width: 199, height: 26)
                        Text(card.keywords[1]).font(.system(size: 16, weight: .light))
                        
                    }
                    
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .frame(width: 199, height: 26)
                        Text(card.keywords[2]).font(.system(size: 16, weight: .light))
                        
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        ZStack{
                            Image(systemName: "goforward").imageScale(.large)
                              .foregroundStyle(.white).onTapGesture {
                                  flipFlashcard()
                                  self.UIState.buttonsShow = true
                              }
                        }
                        
                        
                    }.frame(width: 310, alignment: .center)
                    
                    
                 }
                
            }
        }
        
            .frame(width: cardWidth, height: _id == UIState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
            .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
            .padding()
            .frame(height: 470)
            .frame(maxWidth: 340)
            .background(RoundedRectangle(cornerRadius: 25)
                        .fill(Color(#colorLiteral(red: 0.5411764979362488, green: 0.5333333611488342, blue: 0.886274516582489, alpha: 1))))
            
            .padding()
            
            
            .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
    }
    
    func flipFlashcard() {
        let animationTime = 0.5
        withAnimation(Animation.linear(duration: animationTime)) {
            flashcardRotation += 180
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            contentRotation += 180
            flipped.toggle()
        }
    }
}


struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        
        SnapCarousel(Stats: Stats, UIState: UIState )
        
    }
}
