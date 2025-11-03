import SwiftUI

struct AccordPlacesView: View {
    @State private var navigateToRooms = false
    @State private var navigateToImages = false
    @State private var navigateToBooking = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 16) {
                    headerView(width: geometry.size.width)

                    HStack(spacing: 0) {
                        Button(action: {
                            navigateToRooms = true
                        }) {
                            TabsBarButton(title: "Available Rooms", isSelected: false)
                        }

                        Button(action: {
                            navigateToImages = true
                        }) {
                            TabsBarButton(title: "Images", isSelected: false)
                        }

                        TabsBarButton(title: "Nearby Places", isSelected: true)
                    }
                    .frame(width: geometry.size.width - 32)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)

                    placeList(width: geometry.size.width)
                    bookNowButton(width: geometry.size.width)

                    // Navigation Links
                    NavigationLink(destination: AccordView(), isActive: $navigateToRooms) {
                        EmptyView()
                    }

                    NavigationLink(destination: AccordImageView(), isActive: $navigateToImages) {
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
    }

    private func headerView(width: CGFloat) -> some View {
        HStack {
            Spacer()

            VStack(spacing: 4) {
                Text("Accord Chrome")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.07, green: 0.08, blue: 0.3))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .frame(maxWidth: width * 0.6)
                    .padding(.top, 50)

                HStack(spacing: 4) {
                    Text("4.6")
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
                PlacesItems(imageName: "splace2", label: "Chennai Airport", distance: "4.7 km", width: width)
                PlacesItems(imageName: "Accordplace1", label: "Arignar Anna Zoological Park", distance: "11 km", width: width)
                PlacesItems(imageName: "Arplace2", label: "Valluvar Kottam", distance: "18 km", width: width)
                PlacesItems(imageName: "Accordplace2", label: "Thalappakattu Briyani & Fast Food", distance: "40 m", width: width)
                PlacesItems(imageName: "Accordplace3", label: "Tambaram Sanatorium", distance: "2.4 km", width: width)
            }
        }
        .padding(.horizontal)
    }

    private func bookNowButton(width: CGFloat) -> some View {
        VStack {
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
}

struct TabsBarButton: View {
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

struct PlacesItems: View {
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

struct AccordPlacesView_Previews: PreviewProvider {
    static var previews: some View {
      
            AccordPlacesView()
       
    }
}
