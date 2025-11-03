import SwiftUI

struct UpdateRoomAvailabilityView: View {
    @State private var selectedDate = Date()
    @State private var availableRooms = ""
    @State private var navigateToPinEntry = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.89, green: 0.94, blue: 0.96)
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20) {
                    Text("Update Room Availability")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.horizontal)

                    VStack(spacing: 20) {
                        Text("ITC Grand Chola")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.07, green: 0.08, blue: 0.3))

                        Text("Select date to Update Availability")
                            .foregroundColor(.black)

                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(.white)
                            Text(formattedDate)
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(Color(red: 0.07, green: 0.08, blue: 0.3))
                        .cornerRadius(10)
                        .foregroundColor(.white)

                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
                            .background(Color.white)
                            .cornerRadius(10)

                        VStack(alignment: .leading) {
                            Text("Available Rooms")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)

                            TextField("Enter Available Rooms", text: $availableRooms)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                                )
                                .cornerRadius(10)
                        }

                        Button(action: {
                            if availableRooms.isEmpty {
                                alertMessage = "Please enter number of available rooms"
                                showAlert = true
                            } else {
                                // Directly navigate without server validation
                                navigateToPinEntry = true
                                
                                // If you still need server update, call:
                                // sendAvailabilityToServer()
                            }
                        }) {
                            Text("Update Rooms")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.07, green: 0.08, blue: 0.3))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .background(
                NavigationLink(destination:HotelPinEntryView(), isActive: $navigateToPinEntry) {
                    EmptyView()
                }
                .hidden()
            )
        }
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: selectedDate)
    }

    // Optional: Keep this if you still need to update server
    func sendAvailabilityToServer() {
        guard let url = URL(string: "http://localhost/horobo/update_rooms.php") else {
            alertMessage = "Invalid server URL"
            showAlert = true
            return
        }

        let parameters: [String: Any] = [
            "hotel_name": "ITC Grand Chola",
            "date": formattedDate,
            "available_rooms": availableRooms
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            alertMessage = "Error creating request"
            showAlert = true
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Network error: \(error.localizedDescription)"
                    showAlert = true
                    return
                }

                guard let data = data else {
                    alertMessage = "No data received from server"
                    showAlert = true
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        print("Server response: \(json)")
                        navigateToPinEntry = true // Navigate regardless of server response
                    }
                } catch {
                    alertMessage = "Invalid server response"
                    showAlert = true
                }
            }
        }.resume()
    }
}

struct UpdateRoomAvailabilityView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRoomAvailabilityView()
    }
}
