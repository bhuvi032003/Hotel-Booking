import SwiftUI

struct BookingConfirmationView: View {
    @State private var email: String = "bhuvi@gmail.com" // pre-filled from logged in user
    @State private var hotelName: String = "paramount Inn" // selected hotel
    @State private var rooms = ""
    @State private var aadhar = ""
    @State private var address = ""
    @State private var date = currentDate()
    @State private var id = UUID().uuidString
    @State private var price = ""
    @State private var guest = ""

    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 15) {
                    Group {
                        TextField("Email", text: $email).disabled(true)
                        TextField("Hotel Name", text: $hotelName).disabled(true)
                        TextField("Rooms", text: $rooms).keyboardType(.numberPad)
                        TextField("Aadhar", text: $aadhar)
                        TextField("Address", text: $address)
                        TextField("Date", text: $date).disabled(true)
                        TextField("Booking ID", text: $id).disabled(true)
                        TextField("Price", text: $price).keyboardType(.decimalPad)
                        TextField("Guest Count", text: $guest).keyboardType(.numberPad)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                    Button(action: bookNow) {
                        Text("Book Now")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationTitle("Hotel Booking")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Booking Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func bookNow() {
        guard let url = URL(string: "http://localhost/horobo/hotelbooking.php") else {
            alertMessage = "Invalid server URL"
            showAlert = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let params: [String: String] = [
            "email": email,
            "hotelname": hotelName,
            "rooms": rooms,
            "aadhar": aadhar,
            "address": address,
            "date": date,
            "id": id,
            "price": price,
            "guest": guest
        ]

        request.httpBody = params.map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    alertMessage = "Error: \(error.localizedDescription)"
                    showAlert = true
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    alertMessage = "No data received"
                    showAlert = true
                }
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let message = json["message"] as? String {
                DispatchQueue.main.async {
                    alertMessage = message
                    showAlert = true
                }
            } else {
                DispatchQueue.main.async {
                    alertMessage = "Invalid server response"
                    showAlert = true
                }
            }
        }.resume()
    }

    static func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}

struct BookingConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        BookingConfirmationView()
    }

}
