import SwiftUI

struct AccordImageView: View {
    let imageNames = [
        "Accordimg1", "Accordimg2", "Accordimg3", "Accordimg4",
        "Accordimg6", "Accordimg7", "Accordimg8"
    ]

    @State private var navigateToRooms = false
    @State private var navigateToPlaces = false
    @State private var navigateToBooking = false // NEW

    var body: some View {
        VStack(spacing: 0) {
            // Title pinned to top
            Text("Accord Chrome")
                .font(.title2)
                .bold()
                .foregroundColor(.black)
                .padding(.top, 70)
                .padding(.bottom, 10)

            // Scrollable content below
            ScrollView {
                VStack(spacing: 25) {
                    // Star Rating
                    HStack(spacing: 4) {
                        Text("4.6")
                            .font(.subheadline)
                            .foregroundColor(.black)

                        ForEach(0..<4, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        Image(systemName: "star.leadinghalf.filled")
                            .foregroundColor(.yellow)
                    }

                    // Tabs with navigation
                    HStack(spacing: 0) {
                        Spacer()
                        Button(action: {
                            navigateToRooms = true
                        }) {
                            Text("Available Rooms")
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("Images")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.blue)
                            .underline()
                        Spacer()
                        Button(action: {
                            navigateToPlaces = true
                        }) {
                            Text("Nearby Places")
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    // Image Grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(imageNames, id: \.self) { name in
                            Image(name)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 180, height: 140)
                                .clipped()
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal)

                    // Book Now Button
                    Button(action: {
                        navigateToBooking = true
                    }) {
                        Text("Book Now")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.07, green: 0.08, blue: 0.3))
                            .cornerRadius(16)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 20)

                    // Navigation Links
                    NavigationLink(destination: AccordView(), isActive: $navigateToRooms) {
                        EmptyView()
                    }
                    NavigationLink(destination: AccordPlacesView(), isActive: $navigateToPlaces) {
                        EmptyView()
                    }
                    NavigationLink(destination: BookingConfirmationView(), isActive: $navigateToBooking) {
                        EmptyView()
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(red: 0.91, green: 0.96, blue: 0.99))
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
    }
}

struct AccordImageView_Previews: PreviewProvider {
    static var previews: some View {
      
            AccordImageView()
       
    }
}
