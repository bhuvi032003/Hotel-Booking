import SwiftUI

struct AvailableView: View {
    let hotel: HotelItem

    @State private var selectedAvailabilityDate = Date()
    @State private var checkInDate = Date()
    @State private var checkOutDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State private var guestCount = 2
    @State private var navigateToImages = false
    @State private var navigateToPlaces = false
    @State private var navigateToBooking = false

    private var isRoomsAvailable: Bool {
        Calendar.current.component(.day, from: selectedAvailabilityDate) % 2 == 0
    }

    private var totalPrice: Int {
        let days = Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate).day ?? 0
        return days * guestCount * (Int(Manager.shared.hotelData?.price ?? "0") ?? 0)
    }

    var body: some View {
        ZStack {
            Color(red: 0.89, green: 0.94, blue: 0.96).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 16) {
                    headerView
                    tabBarView
                    availabilityDateSection
                    roomAvailabilitySection
                    hotelDetailsSection
                    rateSection
                    contactSection
                    bookNowButton
                }
                .padding()
            }

            NavigationLink("", destination: ImageGalleryView(), isActive: $navigateToImages).hidden()
            NavigationLink("", destination: NearbyPlacesView(), isActive: $navigateToPlaces).hidden()
            NavigationLink("", destination: BookingConfirmationView(), isActive: $navigateToBooking).hidden()
        }
    }

    private var headerView: some View {
        HStack {
            Text(hotel.name)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            HStack(spacing: 2) {
                ForEach(0..<4, id: \.self) { _ in
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }
                Image(systemName: "star").foregroundColor(.yellow)
            }
        }
    }

    private var tabBarView: some View {
        HStack(spacing: 16) {
            Text("Available Rooms")
                .font(.subheadline)
                .fontWeight(.bold)

            Button("Images") {
                navigateToImages = true
            }

            Button("Nearby Places") {
                navigateToPlaces = true
            }
        }
        .padding(8)
        .background(Color.white)
        .clipShape(Capsule())
    }

    private var availabilityDateSection: some View {
        VStack(spacing: 10) {
            Text("Select date to check Availability").font(.subheadline)

            DatePicker("", selection: $selectedAvailabilityDate, displayedComponents: .date)
                .labelsHidden()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }

    private var roomAvailabilitySection: some View {
        HStack {
            Image(systemName: "door.left.hand.open")
                .resizable()
                .frame(width: 30, height: 30)
            Text(isRoomsAvailable ? "25 Rooms" : "No Rooms")
            Spacer()
            if isRoomsAvailable {
                Text("AC")
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.green)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(isRoomsAvailable ? Color.blue : Color.gray.opacity(0.2))
        .cornerRadius(10)
    }

    private var hotelDetailsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hotel Details").font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                amenity("wifi", "Free Wi-Fi")
                amenity("cup.and.saucer", "Paid breakfast")
                amenity("car", "Free parking")
                amenity("snowflake", "Air-conditioned")
                amenity("washer", "Laundry service")
                amenity("pawprint", "Pet-friendly")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }

    private func amenity(_ icon: String, _ label: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text(label)
            Spacer()
        }
    }

    private var rateSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Rate Details")

            HStack {
                DatePicker("Check-in", selection: $checkInDate, displayedComponents: .date).labelsHidden()
                DatePicker("Check-out", selection: $checkOutDate, displayedComponents: .date).labelsHidden()
            }

            Stepper(value: $guestCount, in: 1...10) {
                Text("Guests: \(guestCount)")
            }

            HStack {
                Image(systemName: "indianrupeesign.circle")
                Text("\(totalPrice)")
                    .font(.title3).fontWeight(.bold)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }

    private var contactSection: some View {
        VStack(spacing: 10) {
            Text("To know more Details Contact")
                .font(.headline)
                .foregroundColor(.blue)

            Link(destination: URL(string: "tel://07448885666")!) {
                HStack {
                    Image(systemName: "phone.fill")
                    Text("Phone: 074488 85666")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
        }
    }

    private var bookNowButton: some View {
        Button("Book Now") {
            navigateToBooking = true
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(20)
    }
}
//struct AvailableView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleHotel = HotelItem(
//            name: "The Saibaba Hotel",
//            address: "123 Temple Street, Chennai",
//            price: "7500",
//            mainImage: "hotel_main",
//            roomImages: ["room1", "room2", "room3"],
//            nearbyPlacesImages: ["nearby1", "nearby2"]
//        )
//        AvailableView(hotel: sampleHotel)
//    }
//}
