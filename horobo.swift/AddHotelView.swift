import SwiftUI
import PhotosUI

// MARK: - Main Admin Panel
struct AdminPanelView: View {
    enum Screen {
        case homeCard
        case bookings
        case addHotel
    }
    
    @State private var isMenuOpen = false
    @State private var selectedScreen: Screen = .addHotel
    @State private var navigateToNext = false
    @State private var showMyBookings = false
    @State private var showProfile = false
    @State private var showLogoutAlert = false
   
    let userEmail: String = "admin@example.com" // Replace with actual user email

    var body: some View {
        NavigationView {
            ZStack {
                // Main content
                Group {
                    switch selectedScreen {
                    case .homeCard:
                        HomeCardView(userEmail: userEmail)
                    case .bookings:
                        AdminBookingsView()
                    case .addHotel:
                        AddHotelView(navigateToNext: navigateToNext)
                    }
                }
                .disabled(isMenuOpen)
                .blur(radius: isMenuOpen ? 3 : 0)

                // Top bar menu button
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                isMenuOpen.toggle()
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.title)
                                .padding()
                        }
                        Spacer()
                    }
                    Spacer()
                }

                // Side Menu
                if isMenuOpen {
                    MenuView(
                        isMenuOpen: $isMenuOpen,
                        showMyBookings: $showMyBookings,
                        showProfile: $showProfile,
                        showLogoutAlert: $showLogoutAlert,
                        userEmail: userEmail
                    )
                    .transition(.move(edge: .leading))
                }
                
                // Navigation Links
                Group {
                    NavigationLink(
                        destination: ProfileView(userEmail: userEmail),
                        isActive: $showProfile
                    ) { EmptyView() }.hidden()
                    
                    NavigationLink(
                        destination: AdminBookingsView(),
                        isActive: $showMyBookings
                    ) { EmptyView() }.hidden()
                }
            }
            .navigationBarHidden(true)
            .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
                Button("Logout", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}

// MARK: - Menu View
struct MenuViews: View {
    @Binding var isMenuOpen: Bool
    @Binding var showMyBookings: Bool
    @Binding var showProfile: Bool
    @Binding var showLogoutAlert: Bool
    let userEmail: String
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                // Profile Button
                Button(action: {
                    isMenuOpen = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showProfile = true
                    }
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "person.crop.circle")
                        Text("My Profile")
                    }
                    .menuButtonStyle()
                }
                
                // Bookings Button
                Button(action: {
                    isMenuOpen = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showMyBookings = true
                    }
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "calendar")
                        Text("My Bookings")
                    }
                    .menuButtonStyle()
                }
                
                // Logout Button
                Button(action: {
                    isMenuOpen = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showLogoutAlert = true
                    }
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "arrow.backward.circle")
                        Text("Logout")
                    }
                    .menuButtonStyle()
                    .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding(.top, 60)
            .padding(.horizontal)
            .frame(width: 240)
            .background(Color(.systemGray6))
            .ignoresSafeArea()
            
            Spacer()
        }
        .background(
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture { withAnimation { isMenuOpen = false } }
        )
    }
}

// MARK: - Profile View
struct ProfilesView: View {
    let userEmail: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("My Profile")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)
            
            VStack(spacing: 16) {
                HStack {
                    Text("Email:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(userEmail)
                }
                
                Divider()
                
                HStack {
                    Text("Role:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("Admin")
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

struct AddHotelView: View {
    @State private var hotelName = ""
    @State private var address = ""
    @State private var price = ""
    @State private var nearbyPlace1 = ""
    @State private var nearbyPlace2 = ""

    @State private var mainImage: UIImage?
    @State private var roomImage1: UIImage?
    @State private var roomImage2: UIImage?
    @State private var roomImage3: UIImage?
    @State private var nearbyImage1: UIImage?
    @State private var nearbyImage2: UIImage?

    @State private var selectedImageType: ImageType?
    @State private var showImagePicker = false
    @State private var navigateToUpdateRoom = false // Added for navigation

    var navigateToNext = false
    
    enum ImageType {
        case main, room1, room2, room3, nearby1, nearby2
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Add Hotel")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.top)

                VStack(alignment: .leading, spacing: 16) {
                    Text("Hotel Name")
                    TextField("Enter hotel name", text: $hotelName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Address")
                    TextField("Enter address", text: $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Text("Price")
                    TextField("Enter price", text: $price)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Main Image")
                    imagePickerButton(image: mainImage, label: "Choose Main Image") {
                        selectedImageType = .main
                        showImagePicker = true
                    }
                }

                Text("Room Images")
                HStack(spacing: 16) {
                    imagePickerButton(image: roomImage1, label: "Room 1") {
                        selectedImageType = .room1
                        showImagePicker = true
                    }
                    imagePickerButton(image: roomImage2, label: "Room 2") {
                        selectedImageType = .room2
                        showImagePicker = true
                    }
                    imagePickerButton(image: roomImage3, label: "Room 3") {
                        selectedImageType = .room3
                        showImagePicker = true
                    }
                }

                Text("Nearby Places")
                HStack(spacing: 16) {
                    TextField("Place 1", text: $nearbyPlace1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Place 2", text: $nearbyPlace2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                HStack(spacing: 16) {
                    imagePickerButton(image: nearbyImage1, label: "Nearby 1") {
                        selectedImageType = .nearby1
                        showImagePicker = true
                    }
                    imagePickerButton(image: nearbyImage2, label: "Nearby 2") {
                        selectedImageType = .nearby2
                        showImagePicker = true
                    }
                }

                Button("Add") {
                    uploadHotel(
                        name: hotelName,
                        address: address,
                        price: price,
                        roomsAvailable: 5,
                        nearbyPlace1: "Temple",
                        nearbyPlace2: "Market",
                        mainImage: mainImage,
                        roomImage1: roomImage1,
                        roomImage2: roomImage2,
                        roomImage3: roomImage3,
                        nearbyImage1: nearbyImage1,
                        nearbyImage2: nearbyImage2
                    ) { success, message in
                        DispatchQueue.main.async {
                            if success {
                                print("✅ Upload successful: \(message)")
                               
                                navigateToUpdateRoom = true
                            } else {
                                print("❌ Upload failed: \(message)")
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .background(
                    NavigationLink(destination:UpdateRoomAvailabilityView(), isActive: $navigateToUpdateRoom) {
                        EmptyView()
                    }
                    .hidden()
                )
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 4)
            .padding()
        }
        .background(Color(red: 0.97, green: 0.98, blue: 1))
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: bindingForSelectedImage())
        }
    }

    func uploadHotel(
        name: String,
        address: String,
        price: String,
        roomsAvailable: Int,
        nearbyPlace1: String,
        nearbyPlace2: String,
        mainImage: UIImage?,
        roomImage1: UIImage?,
        roomImage2: UIImage?,
        roomImage3: UIImage?,
        nearbyImage1: UIImage?,
        nearbyImage2: UIImage?,
        completion: @escaping (Bool, String) -> Void
    ) {
        guard let url = URL(string: ServiceAPI.addhotels) else {
            completion(false, "Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        // Helper: Append form field
        func appendFormField(name: String, value: String) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        // Helper: Append image
        func appendImageField(name: String, image: UIImage?) {
            guard let image = image,
                  let imageData = image.jpegData(compressionQuality: 0.8) else { return }

            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(name).jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }

        // Add text fields
        appendFormField(name: "action", value: "add")
        appendFormField(name: "name", value: name)
        appendFormField(name: "address", value: address)
        appendFormField(name: "price", value: price)
        appendFormField(name: "rooms_available", value: "\(roomsAvailable)")
        appendFormField(name: "nearby_place1", value: nearbyPlace1)
        appendFormField(name: "nearby_place2", value: nearbyPlace2)

        // Add images
        appendImageField(name: "main_image", image: mainImage)
        appendImageField(name: "room_image1", image: roomImage1)
        appendImageField(name: "room_image2", image: roomImage2)
        appendImageField(name: "room_image3", image: roomImage3)
        appendImageField(name: "nearby_image1", image: nearbyImage1)
        appendImageField(name: "nearby_image2", image: nearbyImage2)

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body

        // Send the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, error?.localizedDescription ?? "Unknown error")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    let success = json["status"] as? String == "success"
                    let message = json["message"] as? String ?? "No message"
                    completion(success, message)
                } else {
                    completion(false, "Invalid response")
                }
            } catch {
                completion(false, "JSON parse error: \(error.localizedDescription)")
            }
        }.resume()
    }

    private func bindingForSelectedImage() -> Binding<UIImage?> {
        switch selectedImageType {
        case .main: return $mainImage
        case .room1: return $roomImage1
        case .room2: return $roomImage2
        case .room3: return $roomImage3
        case .nearby1: return $nearbyImage1
        case .nearby2: return $nearbyImage2
        default: return .constant(nil)
        }
    }

    @ViewBuilder
    func imagePickerButton(image: UIImage?, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(8)
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.gray, lineWidth: 1)
                            .frame(width: 100, height: 100)
                        Text(label)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        }
    }
}


struct AdminPanelView_Previews: PreviewProvider {
    static var previews: some View {
        AdminPanelView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider,
                  provider.canLoadObject(ofClass: UIImage.self) else {
                print("Unable to load image")
                return
            }

            provider.loadObject(ofClass: UIImage.self) { object, error in
                if let error = error {
                    print("Image load error: \(error.localizedDescription)")
                    return
                }

                if let uiImage = object as? UIImage {
                    DispatchQueue.main.async {
                        print("Image successfully loaded")
                        self.parent.image = uiImage
                    }
                } else {
                    print("Failed to cast object to UIImage")
                }
            }
        }
    }
}

// MARK: - Supporting Views
struct AdminsBookingsView: View {
    var body: some View {
        Text("Bookings Management")
            .navigationTitle("Bookings")
    }
}


// MARK: - View Modifiers
struct PrimarysButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension View {
    func menuButtonStyle() -> some View {
        self
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.2), radius: 1, x: 0, y: 1)
    }
}

// MARK: - Preview

