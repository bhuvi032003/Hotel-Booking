import SwiftUI

struct saibabaimages: View {
    @State private var navigateToAvailable = false
    @State private var navigateToPlaces = false
    @State private var navigateToBooking = false

    var body: some View {
        
            VStack(spacing: 16) {
                headerView
                tabBarView
                imageGallery
                Spacer()
                bookNowButton

                // Navigation Links
                NavigationLink(destination: Available(), isActive: $navigateToAvailable) { EmptyView() }
                NavigationLink(destination: saibabaplaces(), isActive: $navigateToPlaces) { EmptyView() }
                NavigationLink(destination: BookingConfirmationView(), isActive: $navigateToBooking) { EmptyView() }
            }
            .padding(.top)
            .padding(.horizontal)
            .background(Color(red: 0.89, green: 0.94, blue: 0.96).ignoresSafeArea())
            .navigationBarHidden(true)
        
    }

    
    private var headerView: some View {
        VStack(spacing: 4) {
            Text("The Saibaba Hotel")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.07, green: 0.08, blue: 0.3))

            HStack(spacing: 4) {
                Text("4.4")
                    .font(.subheadline)
                    .foregroundColor(.black)

                ForEach(0..<4, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                }

                Image(systemName: "star")
                    .foregroundColor(.yellow)
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 8)
    }

   
    private var tabBarView: some View {
        HStack(spacing: 10) {
            TabOption(title: "Available Rooms", isSelected: false) {
                navigateToAvailable = true
            }
            TabOption(title: "Images", isSelected: true) {
                // current screen
            }
            TabOption(title: "Nearby Places", isSelected: false) {
                navigateToPlaces = true
            }
        }
        .padding(4)
        .background(Color.gray.opacity(0.3))
        .clipShape(Capsule())
        .padding(.vertical, 30)
        .padding(.horizontal, 1)
    }

   
    private var imageGallery: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 25) {
            ForEach(1..<7) { index in
                Image("saibaba\(index)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 125)
                    .clipped()
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal, 5)
    }

    
    private var bookNowButton: some View {
        Button(action: {
            navigateToBooking = true
        }) {
            Text("Book Now")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(red: 0.07, green: 0.08, blue: 0.3))
                .cornerRadius(20)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}


struct TabOption: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(isSelected ? .white : .black)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(
                    Capsule()
                        .fill(isSelected ? Color(red: 0.07, green: 0.08, blue: 0.3) : Color.clear)
                )
        }
    }
}


struct saibabaimages_Previews: PreviewProvider {
    static var previews: some View {
        saibabaimages()
    }
}
