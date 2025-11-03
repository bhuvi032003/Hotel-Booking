import SwiftUI

struct SignupView: View {
    @State private var selectedRole = "User"
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var contactNumber = ""
    @State private var selectedHotel = ""
    @State private var hotelPin = ""

    @State private var navigateToAdmin = false
    @State private var navigateToUser = false
    @State private var errorMessage = ""

    let roles = ["User", "Admin"]
    let hotels = [
        "The Saibaba Hotel", "A.R.Residency", "Accord Chrome",
        "FabHotel Vijaylakshmi", "Super Townhouse", "Hilton Chennai",
        "ITC Grand Chola", "The Raintree", "Novotel Chennai",
        "JP Chennai Hotel", "Chippy Inn", "FabHotel HomeTreeService Apartment"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)

                    Text("Sign Up")
                        .font(.title)
                        .fontWeight(.bold)

                    // Role Picker
                    Menu {
                        ForEach(roles, id: \.self) { role in
                            Button(role) {
                                selectedRole = role
                                selectedHotel = ""
                                hotelPin = ""
                            }
                        }
                    } label: {
                        HStack {
                            Text(selectedRole)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                            Image(systemName: "chevron.down")
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                    }
                    .frame(width: 160)

                    Group {
                        CustomTextField(placeholder: "Name", text: $name)
                        CustomTextField(placeholder: "Email", text: $email)
                        CustomTextField(placeholder: "Password", text: $password, isSecure: true)
                        CustomTextField(placeholder: "Contact Number", text: $contactNumber)

                        if selectedRole == "Admin" {
                            Menu {
                                ForEach(hotels, id: \.self) { hotel in
                                    Button(hotel) {
                                        selectedHotel = hotel
                                    }
                                }
                            } label: {
                                HStack {
                                    Text(selectedHotel.isEmpty ? "Select Your Hotel" : selectedHotel)
                                        .foregroundColor(selectedHotel.isEmpty ? .gray : .black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                            }
                            .padding(.horizontal)

                            CustomTextField(placeholder: "Hotel Pin", text: $hotelPin)
                        }
                    }

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.horizontal)
                    }

                    Button(action: {
                        signupUser()
                    }) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(25)
                            .padding(.horizontal)
                    }

                    if selectedRole == "User" {
                        HStack {
                            Text("Already have an account?")
                                .foregroundColor(.gray)
                            Button("Log in") {
                                // Add login logic
                            }
                            .foregroundColor(.blue)
                        }
                        .font(.footnote)
                    }
                }
                .padding()
            }
            .background(Color(red: 0.89, green: 0.94, blue: 0.96).ignoresSafeArea())
            .navigationBarHidden(true)
            .background(
                Group {
                    NavigationLink(destination: AdminPanelView(), isActive: $navigateToAdmin) {
                        EmptyView()
                    }
                    NavigationLink(destination: HomeCardView(userEmail: email), isActive: $navigateToUser) {
                        EmptyView()
                    }
                }
            )
        }
    }

    func signupUser() {
        let userURL = "http://localhost/horobo/usersignup.php"
        let adminURL = "http://localhost/horobo/adminsignup.php"
        let urlString = selectedRole == "Admin" ? adminURL : userURL

        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }

        var parameters: [String: String] = [
            "name": name,
            "email": email,
            "password": password,
            "number": contactNumber,
            "role": selectedRole.lowercased()
        ]

        if selectedRole == "Admin" {
            parameters["hotelname"] = selectedHotel
            parameters["hotelpin"] = hotelPin
        }

        let postString = parameters.map {
            "\($0.key)=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        }.joined(separator: "&")

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }

            if let decoded = try? JSONDecoder().decode(SignupResponse.self, from: data) {
                DispatchQueue.main.async {
                    if decoded.status == "success" {
                        if selectedRole == "Admin" {
                            navigateToAdmin = true
                        } else {
                            navigateToUser = true
                        }
                    } else {
                        errorMessage = decoded.message
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid response format"
                }
            }
        }.resume()
    }
}

// MARK: - Supporting Views & Models

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
        .padding(.horizontal)
    }
}


// MARK: - Dummy Views for Navigation



// MARK: - Preview

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
