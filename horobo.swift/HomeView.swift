import SwiftUI

// MARK: - Models
struct HotelResponse: Codable {
    let status: String
    let data: [HotelItem]
}

struct HotelItem: Codable, Identifiable {
    let id: String
    let name: String
    let address: String
    let price: String
    let mainImage: String
    let roomImages: [String]
    let nearbyPlacesImages: NearbyPlacesImagesUnion
    let nearbyPlaces: [String]
    let roomsAvailable: String

    enum CodingKeys: String, CodingKey {
        case id, name, address, price
        case mainImage = "main_image"
        case roomImages, nearbyPlacesImages, nearbyPlaces
        case roomsAvailable = "rooms_available"
    }
}

enum NearbyPlacesImagesUnion: Codable {
    case classType(NearbyPlacesImagesClass)
    case array([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let array = try? container.decode([String].self) {
            self = .array(array)
        } else if let obj = try? container.decode(NearbyPlacesImagesClass.self) {
            self = .classType(obj)
        } else {
            throw DecodingError.typeMismatch(NearbyPlacesImagesUnion.self,
                DecodingError.Context(codingPath: decoder.codingPath,
                debugDescription: "Type mismatch"))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .array(let arr): try container.encode(arr)
        case .classType(let obj): try container.encode(obj)
        }
    }
}

struct NearbyPlacesImagesClass: Codable {
    let the1: String
    enum CodingKeys: String, CodingKey { case the1 = "1" }
}

// MARK: - Main View
struct HomeCardView: View {
    @State private var hotels: [HotelItem] = []
    @State private var selectedHotel: HotelItem?
    @State private var navigateToAvailable = false
    @State private var isMenuOpen = false
    @State private var showMyBookings = false
    @State private var showProfile = false
    @State private var showLogoutAlert = false
    @State private var isLoggedOut = false
    
    let userEmail: String

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(hotels) { hotel in
                            HotelCardView(hotel: hotel) {
                                Manager.shared.hotelData = hotel
                                selectedHotel = hotel
                                navigateToAvailable = true
                            }
                        }
                    }
                    .padding()
                }
                .disabled(isMenuOpen)
                .blur(radius: isMenuOpen ? 3 : 0)
                
                // Menu Button
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation { isMenuOpen.toggle() }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .font(.title)
                                .padding()
                                .foregroundColor(.primary)
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
                }
                
                // Navigation Links
                Group {
                    NavigationLink(
                        destination: selectedHotel.map { AvailableView(hotel: $0) },
                        isActive: $navigateToAvailable
                    ) { EmptyView() }.hidden()
                    
                    NavigationLink(
                        destination: MyBookingsView(userEmail: userEmail),
                        isActive: $showMyBookings
                    ) { EmptyView() }.hidden()
                    
                    NavigationLink(
                        destination: ProfileView(userEmail: userEmail),
                        isActive: $showProfile
                    ) { EmptyView() }.hidden()
                    
                    NavigationLink(
                        destination: LoginView(),
                        isActive: $isLoggedOut
                    ) { EmptyView() }.hidden()
                }
            }
            .navigationBarTitle("Hotels", displayMode: .inline)
            .onAppear(perform: fetchHotels)
            .alert("Are you sure you want to logout?", isPresented: $showLogoutAlert) {
                Button("Logout", role: .destructive) { isLoggedOut = true }
                Button("Cancel", role: .cancel) {}
            }
            .onChange(of: showProfile) { newValue in
                print("Profile navigation state: \(newValue)")
            }
        }
    }
    
    private func fetchHotels() {
        guard let url = URL(string: "http://localhost/horobo/fetch_hotels.php") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let decoded = try? JSONDecoder().decode(HotelResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.hotels = decoded.data
                }
            }
        }.resume()
    }
}

// MARK: - Subviews
struct HotelCardView: View {
    let hotel: HotelItem
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: "http://localhost/horobo/" + hotel.mainImage)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(height: 200)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Text(hotel.name)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(hotel.address)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("₹\(hotel.price)")
                .font(.headline)
                .foregroundColor(.green)
            
            Button("Book Now", action: action)
                .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct MenuView: View {
    @Binding var isMenuOpen: Bool
    @Binding var showMyBookings: Bool
    @Binding var showProfile: Bool
    @Binding var showLogoutAlert: Bool
    let userEmail: String
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                Button(action: {
                    isMenuOpen = false
                    showProfile = true
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "person.crop.circle")
                            .frame(width: 24)
                        Text("My Profile")
                            .font(.system(size: 18, weight: .medium))
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 1, x: 0, y: 1)
                }
                
                Button(action: {
                    isMenuOpen = false
                    showMyBookings = true
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "calendar")
                            .frame(width: 24)
                        Text("My Bookings")
                            .font(.system(size: 18, weight: .medium))
                    }
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 1, x: 0, y: 1)
                }
                
                Button(action: {
                    isMenuOpen = false
                    showLogoutAlert = true
                }) {
                    HStack(spacing: 12) {
                        Image(systemName: "arrow.backward.circle")
                            .frame(width: 24)
                        Text("Logout")
                            .font(.system(size: 18, weight: .medium))
                    }
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 1, x: 0, y: 1)
                }
                
                Spacer()
            }
            .padding(.top, 60)
            .padding(.horizontal)
            .frame(width: 240, alignment: .leading)
            .background(Color(.systemGray6))
            .ignoresSafeArea()
            
            Spacer()
        }
        .background(
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture { withAnimation { isMenuOpen = false } }
        )
        .transition(.move(edge: .leading))
        .zIndex(1)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 8)
            .padding(.horizontal)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

// MARK: - Profile View
struct ProfilesViews: View {
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
                    Text("Member Since:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("2023")
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

// MARK: - Preview
struct HomeCardView_Previews: PreviewProvider {
    static var previews: some View {
        HomeCardView(userEmail: "test@example.com")
    }
}
