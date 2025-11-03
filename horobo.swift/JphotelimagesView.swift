import SwiftUI

struct JphotelimagesView: View {
    @State private var selectedTab = "Images"
    @State private var navigateToAvailable = false
    @State private var navigateToPlaces = false
    @State private var navigateToBooking = false

    let tabs = ["Available Rooms", "Images", "Nearby Places"]
    let imageNames = ["jp1", "jp2", "jp3", "jp4", "jp5", "jp6"]

    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        
            ZStack {
                Color(UIColor.systemGroupedBackground).ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        HStack {
                            Text("JP Chennai Hotel")
                                .font(.title3)
                                .fontWeight(.semibold)

                            Spacer()

                            VStack(alignment: .trailing) {
                                Text("4.7")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                HStack(spacing: 2) {
                                    ForEach(0..<5) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)

                        // Tab Bar
                        HStack {
                            ForEach(tabs, id: \.self) { tab in
                                Button(action: {
                                    selectedTab = tab
                                    if tab == "Available Rooms" {
                                        navigateToAvailable = true
                                    } else if tab == "Nearby Places" {
                                        navigateToPlaces = true
                                    }
                                }) {
                                    Text(tab)
                                        .font(.subheadline)
                                        .foregroundColor(selectedTab == tab ? .blue : .gray)
                                        .padding(.bottom, 4)
                                        .overlay(
                                            Rectangle()
                                                .frame(height: 2)
                                                .foregroundColor(selectedTab == tab ? .blue : .clear),
                                            alignment: .bottom
                                        )
                                }
                                if tab != tabs.last {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal)

                        // Image Grid
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(imageNames, id: \.self) { name in
                                Image(name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: (UIScreen.main.bounds.width - 48) / 2, height: 150)
                                    .clipped()
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)

                        // Book Now Button
                        Button(action: {
                            navigateToBooking = true
                        }) {
                            Text("Book Now")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.07, green: 0.08, blue: 0.3))
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 20)

                        // Navigation Links
                        NavigationLink(destination: JpHotelView(), isActive: $navigateToAvailable) { EmptyView() }
                        NavigationLink(destination: JpPlacesView(), isActive: $navigateToPlaces) { EmptyView() }
                        NavigationLink(destination: BookingConfirmationView(), isActive: $navigateToBooking) { EmptyView() }
                    }
                    .padding(.top)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    
}

struct JphotelimagesView_Previews: PreviewProvider {
    static var previews: some View {
        JphotelimagesView()
    }
}
