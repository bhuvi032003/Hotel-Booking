import SwiftUI

struct ARplacesView: View {
    @State private var navigateToRooms = false
    @State private var navigateToImages = false
    @State private var navigateToBooking = false

    var body: some View {
        
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 25) {
                        headerView(width: geometry.size.width)
                        tabBarView(width: geometry.size.width)
                        placeList(width: geometry.size.width)
                        bookNowButton(width: geometry.size.width)

                        // Hidden NavigationLinks
                        NavigationLink(destination: ARResidencyView(), isActive: $navigateToRooms) {
                            EmptyView()
                        }
                        NavigationLink(destination: ARimageView(), isActive: $navigateToImages) {
                            EmptyView()
                        }
                        NavigationLink(destination: BookingConfirmationView(), isActive: $navigateToBooking) {
                            EmptyView()
                        }
                    }
                    .padding(.bottom, 20)
                    .background(Color(red: 0.89, green: 0.94, blue: 0.96))
                }
                .ignoresSafeArea()
            }
            .navigationBarHidden(true)
        }
    

    private func headerView(width: CGFloat) -> some View {
        HStack {
            Spacer()

            VStack(spacing: 4) {
                Text("AR Residency")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.07, green: 0.08, blue: 0.3))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .frame(maxWidth: width * 0.6)
                    .padding(.top, 50)

                HStack(spacing: 4) {
                    Text("4.5")
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

            Spacer()
        }
        .padding()
    }

    private func tabBarView(width: CGFloat) -> some View {
        HStack(spacing: 0) {
            Button(action: {
                navigateToRooms = true
            }) {
                TabBarButton(title: "Available Rooms", isSelected: false)
            }

            Button(action: {
                navigateToImages = true
            }) {
                TabBarButton(title: "Images", isSelected: false)
            }

            TabBarButton(title: "Nearby Places", isSelected: true)
        }
        .frame(width: width - 32)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }

    private func placeList(width: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Places")
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Spacer()

                Text("Distance")
                    .font(.headline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .padding(.horizontal)

            VStack(spacing: 16) {
                PlaceItem(imageName: "Arplace1", label: "Senganthal Poonga", distance: "1.4 km", width: width)
                PlaceItem(imageName: "Arplace2", label: "Valluvar Kottam", distance: "1.7 km", width: width)
                PlaceItem(imageName: "Arplace3", label: "Government Museum Chennai", distance: "5 km", width: width)
                PlaceItem(imageName: "Arplace4", label: "Chennai Airport", distance: "9 km", width: width)
            }
        }
        .padding(.horizontal)
    }

    private func bookNowButton(width: CGFloat) -> some View {
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
    }
}

// MARK: - TabBarButton View
struct TabBarButtons: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        Text(title)
            .font(.subheadline)
            .foregroundColor(isSelected ? .white : .black)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.blue : Color.clear)
            .cornerRadius(15)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
    }
}

// MARK: - PlaceItem View
struct PlaceItems: View {
    let imageName: String
    let label: String
    let distance: String
    let width: CGFloat

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width * 0.9, height: 125)
                .clipped()
                .cornerRadius(10)
                .frame(maxWidth: .infinity, alignment: .center)

            HStack {
                if !label.isEmpty {
                    Text(label)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                }

                Spacer()

                if !distance.isEmpty {
                    Text(distance)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                }
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

// MARK: - Preview
struct ARplacesView_Previews: PreviewProvider {
    static var previews: some View {
        ARplacesView()
    }
}
