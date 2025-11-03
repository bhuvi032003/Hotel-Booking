import SwiftUI

// MARK: - Booking Model
struct Booking: Identifiable {
    let id = UUID()
    let roomNumber: String
    let hotelName: String
    let checkInDate: String
    var status: BookingStatus = .pending
}

enum BookingStatus {
    case pending, accepted, declined
}

struct AdminBookingsView: View {
    @State private var bookings: [Booking] = [
        Booking(roomNumber: "107", hotelName: "A.R Residency", checkInDate: "17-06-2025"),
        Booking(roomNumber: "302", hotelName: "The Saibaba Hotel", checkInDate: "20-06-2025"),
        Booking(roomNumber: "105", hotelName: "Fab Express", checkInDate: "25-06-2025")
    ]

    var body: some View {
        ZStack {
            Color(red: 0.9, green: 0.95, blue: 1.0)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title
                    HStack {
                        Image(systemName: "book.fill")
                            .foregroundColor(.black)
                        Text("User Bookings")
                            .font(.title3.bold())
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)

                    // Booking cards
                    ForEach(bookings.indices, id: \.self) { index in
                        bookingCard(for: bookings[index], index: index)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 20)
            }
        }
    }

    private func bookingCard(for booking: Booking, index: Int) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Room no. \(booking.roomNumber)")
                    .font(.headline)
                    .foregroundColor(.black)

                Text("at \(booking.hotelName)")
                    .font(.subheadline)
                    .foregroundColor(.blue)

                Text("Check-in date: \(booking.checkInDate)")
                    .font(.subheadline.bold())
                    .foregroundColor(.black)
            }

            // Action buttons or status
            if booking.status == .pending {
                HStack {
                    Button(action: {
                        bookings[index].status = .accepted
                    }) {
                        Text("Accept")
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }

                    Button(action: {
                        bookings[index].status = .declined
                    }) {
                        Text("Decline")
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                }
            } else {
                Text(booking.status == .accepted ? "✅ Accepted" : "❌ Declined")
                    .font(.subheadline)
                    .foregroundColor(booking.status == .accepted ? .green : .red)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
    }
}

// MARK: - Preview
struct AdminBookingsView_Previews: PreviewProvider {
    static var previews: some View {
        AdminBookingsView()
    }
}
