import SwiftUI

@main
struct HoRoBoApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                NavigationStack{
                    SplashScreenView()
                }
            } else {
               
            }
        }
    }
    
}
