//
//  GameStartScreenView.swift
//  Flashdecks
//
//  Created by Francesco Iaccarino on 19/11/21.
//

import SwiftUI

var UIState: UIStateModel = UIStateModel()
var Stats: SessionStats = SessionStats()

// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

/*extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    }
}*/


//HAPTICS STRUCTURE
class HapticManager {
    static let instance = HapticManager() //Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct GameStartScreenView: View {
    @State var willMoveToNextScreen = false
    
    let deck: Flashdeck
    
    var body: some View {
        
        VStack{
            
            Spacer()
        Image(systemName: "iphone.radiowaves.left.and.right")
                .resizable()
                .frame(width: 150.0, height: 100.0)
                .rotationEffect(.degrees(-13))
                .foregroundColor(Color(UIColor(named: "PrimaryViolet")!))
           
            Text("Shake to start the session")
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .font(.system(size: 22))
                .minimumScaleFactor(0.01)
                
                .onShake {
                    HapticManager.instance.notification(type: .success)
                    HapticManager.instance.notification(type: .success)
                    HapticManager.instance.notification(type: .warning)
                  //  HapticManager.instance.impact(style: .rigid)
                    willMoveToNextScreen=true
                    
                }
                
            
            Spacer()
       
        }.navigate(to: SnapCarousel(Stats: Stats, UIState: UIState, deck: deck), when: $willMoveToNextScreen)
    }
}

//struct GameStartScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        GameStartScreenView()
//    }
//}
