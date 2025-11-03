import SwiftUI

struct ARResidencyView: View {
    @State private var checkInDate = Date()
    @State private var checkOutDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    @State private var guestCount = 2

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Header
                HStack {
                    Text("A.R Residency")
                        .font(.title2).bold()
                    Spacer()
                    ForEach(0..<4) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                }

                // Tabs
                HStack(spacing: 20) {
                    Text("Available Rooms").bold()
                    Text("Images")
                    Text("Nearby Places")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)

                Text("Select date to check Availability")
                    .font(.subheadline)

                // Selected date box
                HStack {
                    Image(systemName: "calendar")
                    Text("06-06-2025").bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                // Rooms section
                HStack {
                    Image("room_icon") // Replace with your asset
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("17 Rooms").bold()
                    Spacer()
                    Text("AC")
                        .bold()
                        .padding(8)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 1)

                // Hotel Details
                VStack(alignment: .leading, spacing: 16) {
                    Text("Hotel Details")
                        .font(.headline).bold()

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: "wifi")
                            Text("Free Wi-Fi")
                        }
                        HStack {
                            Image(systemName: "cup.and.saucer.fill")
                            Text("Paid breakfast")
                        }
                        HStack {
                            Image(systemName: "parkingsign.circle")
                            Text("Free parking")
                        }
                        HStack {
                            Image(systemName: "snowflake")
                            Text("Air-conditioned")
                        }
                        HStack {
                            Image(systemName: "washer")
                            Text("Laundry service")
                        }
                        HStack {
                            Image(systemName: "pawprint")
                            Text("Pet-friendly")
                        }
                    }
                    .font(.subheadline)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 1)

                // Rate details
                Text("Rate Details from AR Residency")
                    .font(.subheadline)

                HStack(spacing: 12) {
                    DatePicker("", selection: $checkInDate, displayedComponents: .date)
                        .labelsHidden()
                    DatePicker("", selection: $checkOutDate, displayedComponents: .date)
                        .labelsHidden()

                    HStack {
                        Image(systemName: "person.2.fill")
                        Text("\(guestCount)")
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }

                // Price
                VStack {
                    Text("₹").font(.title2).bold()
                    Text("45000").font(.title).bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 1)

                // Contact
                VStack(alignment: .leading, spacing: 8) {
                    Text("To know more Details Contact")
                        .font(.subheadline).bold()

                    HStack {
                        Text("Phone: ").bold()
                        Text("074488 85666").foregroundColor(.blue)
                        Spacer()
                        Image("call_icon") // Replace with your asset
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 1)
                }

                // Book Now Button
                Button(action: {
                    print("Book Now tapped")
                }) {
                    Text("Book Now")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
            .padding()
            .background(Color(red: 0.89, green: 0.94, blue: 0.96))
        }
    }
}
