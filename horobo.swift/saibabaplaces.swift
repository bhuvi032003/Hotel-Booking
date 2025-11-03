import SwiftUI

struct saibabaplaces: View {
    @State private var navigateToBooking = false

    var body: some View {
        
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 16) {
                        headerView(width: geometry.size.width)
                        tabBarView(width: geometry.size.width)
                        placeList(width: geometry.size.width)
                        Spacer()
                        bookNowButton(width: geometry.size.width, navigateToBooking: $navigateToBooking)

                        NavigationLink(
                            destination: BookingConfirmationView(),
                            isActive: $navigateToBooking
                        ) {
                            EmptyView()
                        }
                    }
                    
                    .frame(minHeight: geometry.size.height, maxHeight: .infinity, alignment: .top)
                    .padding(.bottom, 20)
                    .background(Color(red: 0.89, green: 0.94, blue: 0.96))
                }
               
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationBarHidden(true)
        
    }

    private func headerView(width: CGFloat) -> some View {
        HStack {
            VStack(spacing: 4) {
                Text("The Saibaba Hotel")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.07, green: 0.08, blue: 0.3))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .frame(maxWidth: width * 0.6)

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

            Spacer()
        }
        .padding()
    }

    private func tabBarView(width: CGFloat) -> some View {
        HStack(spacing: 0) {
            NavigationLink(destination: Available()) {
                TabBarButton(title: "Available Rooms", isSelected: false)
            }

            NavigationLink(destination: saibabaimages()) {
                TabBarButton(title: "Images", isSelected: false)
            }

            TabBarButton(title: "Nearby Places", isSelected: true)
        }
        .frame(width: max(width - 32, 0))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }

    private func placeList(width: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Places")
                    .font(.headline)
                Spacer()
                Text("Distance")
                    .font(.headline)
            }
            .padding(.horizontal)

            VStack(spacing: 16) {
                PlaceItem(imageName: "splace1", label: "Spencer Plaza", distance: "1.9 km", width: width)
                PlaceItem(imageName: "splace2", label: "Chennai Airport", distance: "9 km", width: width)
                PlaceItem(imageName: "splace3", label: "Senganthal Poonga", distance: "1.4 km", width: width)
                PlaceItem(imageName: "splace4", label: "Elliot's Beach", distance: "9 km", width: width)
            }
        }
        .padding(.horizontal)
    }

    private func bookNowButton(width: CGFloat, navigateToBooking: Binding<Bool>) -> some View {
        Button(action: {
            navigateToBooking.wrappedValue = true
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

struct TabBarButton: View {
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

struct PlaceItem: View {
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

struct saibabaplaces_Previews: PreviewProvider {
    static var previews: some View {
        saibabaplaces()
    }
}
