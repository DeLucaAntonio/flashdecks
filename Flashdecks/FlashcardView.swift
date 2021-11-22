//
//  FlashcardView.swift
//  Flashdecks
//
//  Created by Francesco Iaccarino on 17/11/21.
//

import SwiftUI




struct ProgressBar: View {
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
            }.cornerRadius(45.0)
        }
    }
}





struct FlashcardView: View {
    
    @State var progressValue: Float = 0.0
    @State var cardList: [Flashcard] = [Flashcard(id: "020", name: "Object", Keywords: ["class", "method", "instance"], definition: "le classi sono molto belle"), Flashcard(id: "030", name: "Bestemmioni", Keywords: ["KTM", "KTM+", "KTM++"], definition: "le classi sono molto belle"), Flashcard(id: "020", name: "Object", Keywords: ["class", "method", "instance"], definition: "le classi sono molto belle")]
    
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = true
    @State var touched: Bool = false
    
      
    @State var timer: Timer? = nil
    
    var body: some View {
        
        
        NavigationView{
            
            
            VStack{
                ProgressBar(value: $progressValue).frame(width: 330,height: 20)
                
                
                HStack(spacing:190){
                    Text("5/10").font(.system(size: 18, weight: .regular))
                    
                    HStack {
                    //image 1
                        Image(systemName: "timer")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.55, blue: 1, alpha: 1)))
                        .font(Font.title.weight(.semibold))
                        
                    //03:20 s
                        Text("\(hours):\(minutes):\(seconds)").font(.system(size: 18, weight: .regular)).tracking(0.35)
                    }
                    
                }.frame(height: 40)
                
                Spacer()
                
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(alignment: .center, spacing: 20){
                        Spacer()
                        
                        ForEach(cardList, id: \.id){ card in
                            
                            
                            FlashcardDisplay(front: {
                                
                                VStack {
                                    Spacer()
                                    Text(card.name).font(.system(size: 40, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).tracking(0.36)
                                    Spacer()
                                    ZStack{
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                        .frame(width: 199, height: 26)
                                        Text(card.Keywords[0]).font(.system(size: 16, weight: .light))
                                        
                                    }
                                    
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                        .frame(width: 199, height: 26)
                                        Text(card.Keywords[1]).font(.system(size: 16, weight: .light))
                                        
                                    }
                                    
                                    
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                        .frame(width: 199, height: 26)
                                        Text(card.Keywords[2]).font(.system(size: 16, weight: .light))
                                        
                                    }
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        ZStack{
                                            Image(systemName: "goforward").imageScale(.large)
                                              .foregroundStyle(.white).onTapGesture {
                                                  touched = true
                                              }
                                        }
                                        
                                    }
                                    
                                    
                                 }
                                
                                }, back: {
                                    ZStack {
                                    //Rectangle 25
                                        RoundedRectangle(cornerRadius: 10)
                                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                        .frame(width: 260, height: 360)

                                    //Objects are the things you...
                                        Text(card.definition).font(.system(size: 16, weight: .light)).tracking(0.35)
                                            .frame(width: 230, height: 316)
                                        }
                                }).frame(width: 330, height: 470, alignment: .center)
                            
                        }
                        
                        
                    }
                    
                }
                
                Spacer()
                
                HStack{
                    Button {
                                   // action
                    } label: {
                            Text("Wrong").frame(maxWidth: 107)
                            .padding()
                            .foregroundColor(.black)
                    }.background(Color(#colorLiteral(red: 0.8873699307441711, green: 0.8873699307441711, blue: 0.8873699307441711, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    
                    Button {
                                   // action
                    } label: {
                            Text("Right").frame(maxWidth: 107)
                            .padding()
                            .foregroundColor(.white)
                    }.background(Color(#colorLiteral(red: 0.5411764979362488, green: 0.5333333611488342, blue: 0.886274516582489, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                }
                Spacer()
               
                    
            }.navigationBarTitle("hello")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar{
                Button("Done") {
                    print("Help tapped!")
                }
            }
                
                
                
        }.onAppear {
            self.startTimer()
        }
    }
    
    struct FlashcardDisplay<Front, Back>: View where Front: View, Back: View {
        var front: () -> Front
        var back: () -> Back
        
        
        @State var flipped: Bool = false
        @State var flashcardRotation = 0.0
        @State var contentRotation = 0.0
        //@State var isSelected : Bool 
        
        init(@ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
            self.front = front
            self.back = back
            
        }
        
        var body: some View {
            
            ZStack {
                if flipped {
                    
                    back()
                    
                
                } else {
                    front()
                    
                }
            }
            .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
            .padding()
            .frame(height: 470)
            .frame(maxWidth: 330)
            .background(RoundedRectangle(cornerRadius: 25)
                        .fill(Color(#colorLiteral(red: 0.5411764979362488, green: 0.5333333611488342, blue: 0.886274516582489, alpha: 1))))
            
            .padding()
            
            .onTapGesture {
                flipFlashcard()
                
                //touched.toggle()
                //touched
            }
            .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
            .cornerRadius( 8 )
            .shadow( color: Color( "shadow1" ), radius: 4, x: 0, y: 4 )
            .transition( AnyTransition.slide )
            .animation( .spring() )
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


struct FlashcardView_Previews: PreviewProvider {
    static var previews: some View {
        FlashcardView()
        
    }
}

