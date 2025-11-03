import SwiftUI

struct MyBookingsView: View {
    let userEmail: String
    @State private var bookings: [BookingItem] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading bookings...")
            } else if let error = errorMessage {
                Text(error).foregroundColor(.red)
            } else if bookings.isEmpty {
                Text("No bookings found.")
            } else {
                List(bookings) { booking in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Hotel: \(booking.hotelname)").font(.headline)
                        Text("Date: \(booking.date)")
                        Text("Guests: \(booking.guest)")
                        Text("Rooms: \(booking.rooms)")
                        Text("Price: ₹\(booking.price)")
                        Text("Booking ID: \(booking.id)").font(.caption).foregroundColor(.gray)
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .padding()
        .navigationTitle("My Bookings")
        .onAppear(perform: fetchBookings)
    }

    func fetchBookings() {
        guard let url = URL(string: "http://localhost/horobo/fetch_bookings.php?email=\(userEmail)") else {
            self.errorMessage = "Invalid URL"
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    errorMessage = "No data received"
                }
                return
            }

            do {
                let response = try JSONDecoder().decode([BookingItem].self, from: data)
                DispatchQueue.main.async {
                    bookings = response
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Decoding error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

struct BookingItem: Identifiable, Codable {
    let id: String
    let email: String
    let hotelname: String
    let rooms: String
    let aadhar: String
    let address: String
    let date: String
    let price: String
    let guest: String
}
