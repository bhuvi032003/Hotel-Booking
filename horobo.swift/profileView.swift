import SwiftUI

struct ProfileView: View {
    let userEmail: String
    
    @State private var name: String = "Bhuvi V"
    @State private var phone: String = "+91 9876543210"
    @State private var address: String = "Chennai, India"
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Profile Picture
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundColor(.blue)
                .padding(.top, 40)
            
            Text("My Profile")
                .font(.largeTitle)
                .bold()
            
            VStack(alignment: .leading, spacing: 16) {
                // Email (non-editable)
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.gray)
                    Text(userEmail)
                        .font(.body)
                }
                
                // Editable Name
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                    if isEditing {
                        TextField("Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text("Name: \(name)")
                    }
                }
                
                // Editable Phone
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.gray)
                    if isEditing {
                        TextField("Phone", text: $phone)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.phonePad)
                    } else {
                        Text("Phone: \(phone)")
                    }
                }
                
                // Editable Address
                HStack {
                    Image(systemName: "house.fill")
                        .foregroundColor(.gray)
                    if isEditing {
                        TextField("Address", text: $address)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text("Address: \(address)")
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal)
            
            // Edit / Save Button
            Button(action: {
                isEditing.toggle()
            }) {
                Text(isEditing ? "Save" : "Edit Profile")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isEditing ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(userEmail: "bhuvi@gmail.com")
        }
    }
}
