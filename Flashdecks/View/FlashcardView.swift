////
////  FlashcardView.swift
////  Flashdecks
////
////  Created by Francesco Iaccarino on 17/11/21.
////
//
//import SwiftUI
//
//var flip = FlipIcon()
//
//
//struct FlipIcon: View{
//    @State var touched: Bool = false
//
//    var body: some View{
//
//          Image(systemName: "goforward").imageScale(.large)
//            .foregroundStyle(.white).onTapGesture {
//                touched = true
//            }
//
//    }
//}
//
//
//
//
//struct ProgressBar: View {
//    @Binding var value: Float
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
//                    .opacity(0.3)
//                    .foregroundColor(Color(UIColor.systemTeal))
//            }.cornerRadius(45.0)
//        }
//    }
//}
//
//
//
//struct FlashcardDisplay<Front, Back>: View where Front: View, Back: View {
//    var front: () -> Front
//    var back: () -> Back
//
//
//    @State var flipped: Bool = false
//
//    @State var flashcardRotation = 0.0
//    @State var contentRotation = 0.0
//
//    init(@ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
//        self.front = front
//        self.back = back
//    }
//
//    var body: some View {
//        ZStack {
//            if flipped {
//                back()
//
//            } else {
//                front()
//
//            }
//        }
//        .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
//        .padding()
//        .frame(height: 470)
//        .frame(maxWidth: 330)
//        .background(RoundedRectangle(cornerRadius: 25)
//                    .fill(Color(#colorLiteral(red: 0.5411764979362488, green: 0.5333333611488342, blue: 0.886274516582489, alpha: 1))))
//
//
//        .padding()
//
//        .onTapGesture {
//            flipFlashcard()
//
//        }
//        .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
//    }
//
//    func flipFlashcard() {
//        let animationTime = 0.5
//        withAnimation(Animation.linear(duration: animationTime)) {
//            flashcardRotation += 180
//        }
//
//        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
//            contentRotation += 180
//            flipped.toggle()
//        }
//    }
//}
//
//struct FlashcardView: View {
//
//    @State var progressValue: Float = 0.0
//    @State var cardList: [Flashcard] = [Flashcard(id: "020", name: "Object", Keywords: ["class", "method", "instance"], definition: "le classi sono molto belle"), Flashcard(id: "030", name: "Bestemmioni", Keywords: ["KTM", "KTM+", "KTM++"], definition: "le classi sono molto belle")]
//
//
//
//    var body: some View {
//        /*let flipIcon = Image(systemName: "goforward").imageScale(.large)
//            .foregroundStyle(.white)*/
//
//        NavigationView{
//
//
//
//            VStack{
//                ProgressBar(value: $progressValue).frame(width: 330,height: 20)
//
//                HStack(spacing:190){
//                    Text("5/10").font(.system(size: 18, weight: .regular))
//
//                    Text("􀐱").font(.system(size: 18, weight: .regular)).foregroundColor(Color(#colorLiteral(red: 0.56, green: 0.55, blue: 1, alpha: 1))).tracking(0.35) + Text(" 02:30 s").font(.system(size: 18, weight: .regular)).tracking(0.35)
//
//                }.frame(height: 40)
//
//                Spacer()
//
//
//                ScrollView(.horizontal, showsIndicators: false){
//                    HStack(alignment: .center, spacing: 20){
//                        Spacer()
//
//                        ForEach(cardList, id: \.id){ card in
//
//
//
//                            FlashcardDisplay(front: {
//
//                                VStack {
//                                    Spacer()
//                                    Text(card.name).font(.system(size: 40, weight: .bold)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).tracking(0.36)
//                                    Spacer()
//                                    ZStack{
//
//                                        RoundedRectangle(cornerRadius: 10)
//                                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
//                                        .frame(width: 199, height: 26)
//                                        Text(card.Keywords[0]).font(.system(size: 16, weight: .light))
//
//                                    }
//
//                                    ZStack{
//                                        RoundedRectangle(cornerRadius: 10)
//                                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
//                                        .frame(width: 199, height: 26)
//                                        Text(card.Keywords[1]).font(.system(size: 16, weight: .light))
//
//                                    }
//
//
//                                    ZStack{
//                                        RoundedRectangle(cornerRadius: 10)
//                                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
//                                        .frame(width: 199, height: 26)
//                                        Text(card.Keywords[2]).font(.system(size: 16, weight: .light))
//
//                                    }
//                                    Spacer()
//                                    HStack{
//                                        Spacer()
//                                        ZStack{
//                                            flip
//                                        }
//
//                                    }
//
//
//                                    }
//
//                                }, back: {
//                                    ZStack {
//                                    //Rectangle 25
//                                        RoundedRectangle(cornerRadius: 10)
//                                        .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
//                                        .frame(width: 260, height: 360)
//
//                                    //Objects are the things you...
//                                        Text(card.definition).font(.system(size: 16, weight: .light)).tracking(0.35)
//                                            .frame(width: 230, height: 316)
//                                        }
//                                }).frame(width: 330, height: 470, alignment: .center)
//
//                        }
//
//
//                    }
//
//                }
//
//                Spacer()
//
//                HStack{
//                    Button {
//                                   // action
//                    } label: {
//                            Text("Wrong").frame(maxWidth: 107)
//                            .padding()
//                            .foregroundColor(.black)
//                    }.background(Color(#colorLiteral(red: 0.8873699307441711, green: 0.8873699307441711, blue: 0.8873699307441711, alpha: 1)))
//                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//
//
//                    Button {
//                                   // action
//                    } label: {
//                            Text("Right").frame(maxWidth: 107)
//                            .padding()
//                            .foregroundColor(.white)
//                    }.background(Color(#colorLiteral(red: 0.5411764979362488, green: 0.5333333611488342, blue: 0.886274516582489, alpha: 1)))
//                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
//
//                }
//                Spacer()
//
//
//                }.navigationBarTitle("hello")
//                .navigationBarTitleDisplayMode(.inline)
//
//
//            }
//        }
//
//    }
//
//
//struct FlashcardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FlashcardView()
//
//    }
//}
