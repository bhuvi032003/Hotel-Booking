import SwiftUI

struct TownhouseImageView: View {
    @State private var navigateToBooking = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerSection
                tabBarSection
                imageGrid
                Spacer(minLength: 10)

                NavigationLink(destination: BookingConfirmationView(), isActive: $navigateToBooking) {
                    EmptyView()
                }

                bookNowButton
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .background(Color(red: 0.89, green: 0.94, blue: 0.96))
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }

    private var headerSection: some View {
        HStack {
            VStack(spacing: 4) {
                Text("Super Townhouse")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.07, green: 0.08, blue: 0.3))

                HStack(spacing: 4) {
                    Text("4.5").font(.subheadline)
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

            Spacer()
        }
        .padding(.top, 50)
    }

    private var tabBarSection: some View {
        HStack(spacing: 0) {
            NavigationLink(destination: TownhouseView()) {
                tabButton(title: "Available Rooms", isSelected: false)
            }

            tabButton(title: "Images", isSelected: true)

            NavigationLink(destination: TownhousePlacesView()) {
                tabButton(title: "Nearby Places", isSelected: false)
            }
        }
        .padding(6)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func tabButton(title: String, isSelected: Bool) -> some View {
        Text(title)
            .font(.subheadline)
            .foregroundColor(isSelected ? .white : .black)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.blue : Color.clear)
            .cornerRadius(15)
    }

    private var imageGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            ForEach(["townhouse1", "townhouse2", "townhouse3", "townhouse4", "townhouse5", "townhouse6", "townhouse7"], id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 120)
                    .clipped()
                    .cornerRadius(10)
            }
        }
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
    }
}

struct BookingView: View {
    var body: some View {
        Text("Booking Confirmed!")
            .font(.largeTitle)
            .foregroundColor(.green)
    }
}

struct TownhouseImageView_Previews: PreviewProvider {
    static var previews: some View {
   
            TownhouseImageView()
       
    }
}
