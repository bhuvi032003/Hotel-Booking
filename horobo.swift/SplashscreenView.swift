import SwiftUI

struct SplashScreenView: View {
    @State private var navigate = false

    var body: some View {
        NavigationView {
        
            ZStack {
                Color(red: 0.89, green: 0.94, blue: 0.96)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    VStack(spacing: 4) {
                        Image("logo") 
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)

                        
                        Text("“Book it. Love it”")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .padding(.top, 5)
                    }

                    Spacer()
                }

                NavigationLink(destination: LoginView(), isActive: $navigate) {
                    EmptyView()
                }
            }
            .onTapGesture {
                navigate = true
            }
            .navigationBarHidden(true)
        }
    }
    }


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
