import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var navigateToUserHome = false
    @State private var navigateToAdminHome = false
    @State private var errorMessage = ""
    @State private var userData: UserData?

    var body: some View {
      
            ZStack {
                Color(red: 0.9, green: 0.95, blue: 1.0).ignoresSafeArea()

                VStack {
                    Spacer()

                    VStack(spacing: 20) {
                        Image(systemName: "house.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.black)

                        Text("ROOM\nBOOKING")
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .foregroundColor(.black)

                        Text("Log In")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.black)

                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .padding()
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue))
                            .padding(.horizontal)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue))
                            .padding(.horizontal)

                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.footnote)
                        }

                        NavigationLink(destination: HomeCardView(userEmail: ""), isActive: $navigateToUserHome) {
                            EmptyView()
                        }

                        NavigationLink(destination: AdminPanelView(), isActive: $navigateToAdminHome) {
                            EmptyView()
                        }

                        Button("Log In") {
                            loginUser()
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)

                        VStack(spacing: 4) {
                            Text("Don't have an account?")
                                .font(.footnote)
                                .foregroundColor(.black)

                            NavigationLink(destination: SignupView()) {
                                Text("Create Account")
                                    .foregroundColor(.blue)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                            }
                        }
                    }

                    Spacer()
                }
                .padding()
            }
            .navigationBarHidden(true)
       
    }

    func loginUser() {
        let parameters = [
            "email": email,
            "password": password
        ]

        APIHandler.shared.postAPIValues(
            type: LoginResponse.self,
            apiUrl: ServiceAPI.loginURL,
            method: "POST",
            formData: parameters
            ) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        if response.status == "success" {
                            // ✅ Remove: self.userData = response.data
                            if response.role.lowercased() == "admin" {
                                self.navigateToAdminHome = true
                            } else {
                                self.navigateToUserHome = true
                            }
                        } else {
                            self.errorMessage = response.message
                        }

                    case .failure(let error):
                        self.errorMessage = "Login failed: \(error.localizedDescription)"
                    }
                }
            }

        }
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

