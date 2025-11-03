import SwiftUI

struct RaintreeimagesView: View {
    let imageNames = ["room1", "room2", "room3", "room4", "room5", "room6", "room7", "room8"]

    @State private var navigateToRooms = false
    @State private var navigateToPlaces = false
    @State private var navigateToBooking = false  // <-- New

    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 4) {
                Text("The Raintree")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 50)

                HStack(spacing: 4) {
                    Text("4.4")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.black)

                    ForEach(0..<5) { index in
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(index < 4 ? .yellow : .gray)
                    }
                }
            }
            .padding(.top, 20)

            // Tab Bar
            HStack(spacing: 30) {
                Button {
                    navigateToRooms = true
                } label: {
                    Text("Available Rooms")
                        .foregroundColor(.blue)
                        .font(.subheadline)
                        .bold()
                }

                Text("Images")
                    .foregroundColor(.black.opacity(0.6))
                    .font(.subheadline)

                Button {
                    navigateToPlaces = true
                } label: {
                    Text("Nearby Places")
                        .foregroundColor(.black.opacity(0.6))
                        .font(.subheadline)
                }
            }
            .padding(.vertical, 12)

            Spacer().frame(height: 10)

            // Image Grid
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                    ForEach(imageNames, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 130)
                            .frame(width: UIScreen.main.bounds.width * 0.44)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }

            // Book Now Button
            Button {
                navigateToBooking = true
            } label: {
                Text("Book Now")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.07, green: 0.08, blue: 0.3))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
            }

            // Navigation Links
            NavigationLink(destination: RaintreeView(), isActive: $navigateToRooms) {
                EmptyView()
            }
            NavigationLink(destination: RainPlacesView(), isActive: $navigateToPlaces) {
                EmptyView()
            }
            NavigationLink(destination: BookingConfirmationView(), isActive: $navigateToBooking) {
                EmptyView()
            }
        }
        .background(Color(red: 236/255, green: 244/255, blue: 255/255))
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct RaintreeimagesView_Previews: PreviewProvider {
    static var previews: some View {
     
            RaintreeimagesView()
        
    }
}
