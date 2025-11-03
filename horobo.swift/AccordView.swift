import SwiftUI

struct AccordView: View {
    @State private var selectedAvailabilityDate = Date()
    @State private var checkInDate = Date()
    @State private var checkOutDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State private var guestCount = 2

    @State private var navigateToImages = false
    @State private var navigateToPlaces = false
    @State private var navigateToBookingConfirmation = false

    private var isRoomsAvailable: Bool {
        let day = Calendar.current.component(.day, from: selectedAvailabilityDate)
        return day % 2 == 0
    }

    private var totalPrice: Int {
        let days = Calendar.current.dateComponents([.day], from: checkInDate, to: checkOutDate).day ?? 0
        return days * guestCount * 7500
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
                .frame(maxWidth: .infinity, alignment: .top)
            }

            // Navigation triggers
            VStack {
                NavigationLink("", destination: AccordImageView(), isActive: $navigateToImages)
                    .hidden()
                NavigationLink("", destination: AccordPlacesView(), isActive: $navigateToPlaces)
                    .hidden()
                NavigationLink("", destination: BookingConfirmationView(), isActive: $navigateToBookingConfirmation)
                    .hidden()
            }
        }
        .navigationBarHidden(true)
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Accord Chrome")
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
    }

    private var tabBarView: some View {
        HStack(spacing: 16) {
            Text("Available Rooms")
                .font(.subheadline)
                .fontWeight(.bold)

            Button(action: {
                navigateToImages = true
            }) {
                Text("Images")
                    .font(.subheadline)
            }

            Button(action: {
                navigateToPlaces = true
            }) {
                Text("Nearby Places")
                    .font(.subheadline)
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
                .datePickerStyle(.compact)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.07, green: 0.08, blue: 0.3))
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }

    private var roomAvailabilitySection: some View {
        HStack {
            Image(systemName: "door.left.hand.open")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(isRoomsAvailable ? .white : .black)

            Text(isRoomsAvailable ? "17 Rooms" : "No Rooms")
                .font(.headline)
                .foregroundColor(isRoomsAvailable ? .white : .black)

            Spacer()

            if isRoomsAvailable {
                Text("AC")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.green)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(isRoomsAvailable ? Color(red: 0.07, green: 0.08, blue: 0.3) : Color.gray.opacity(0.2))
        .cornerRadius(10)
    }

    private var hotelDetailsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hotel Details").font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                amenityView(icon: "wifi", label: "Free Wi-Fi")
                amenityView(icon: "cup.and.saucer", label: "Paid breakfast")
                amenityView(icon: "car", label: "Free parking")
                amenityView(icon: "snowflake", label: "Air-conditioned")
                amenityView(icon: "washer", label: "Laundry service")
                amenityView(icon: "pawprint", label: "Pet-friendly")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }

    private func amenityView(icon: String, label: String) -> some View {
        HStack {
            Image(systemName: icon).frame(width: 20)
            Text(label)
            Spacer()
        }
    }

    private var rateSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Rate Details from AR Residency").font(.subheadline)

            HStack(spacing: 10) {
                DatePicker("Check-in", selection: $checkInDate, displayedComponents: .date)
                    .labelsHidden()
                DatePicker("Check-out", selection: $checkOutDate, displayedComponents: .date)
                    .labelsHidden()
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
            .frame(maxWidth: .infinity)
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
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(8)
            }
        }
    }

    private var bookNowButton: some View {
        Button(action: {
            navigateToBookingConfirmation = true
        }) {
            Text("Book Now")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0.07, green: 0.08, blue: 0.3))
                .cornerRadius(20)
        }
    }
}

struct AccordView_Previews: PreviewProvider {
    static var previews: some View {
     
            AccordView()
       
    }
}
