import SwiftUI


struct Hotel: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let address: String
    let price: String
}


struct DashBoardView: View {
    @State private var isMenuOpen = false

    var body: some View {
        ZStack(alignment: .leading) {
            
                HomeView(isMenuOpen: $isMenuOpen)
                    .navigationBarHidden(true) // Hide the Dashboard title
            }
            .disabled(isMenuOpen)
            .blur(radius: isMenuOpen ? 5 : 0)

            if isMenuOpen {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isMenuOpen = false
                        }
                    }

                SideMenuView(isMenuOpen: $isMenuOpen)
                    .frame(width: 250)
                    .transition(.move(edge: .leading))
                    .zIndex(1)
            }
        }
    }



struct SideMenuView: View {
    @Binding var isMenuOpen: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Menu")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                    .padding(.leading)

                Circle()
                    .fill(Color.gray)
                    .frame(width: 60, height: 60)
                    .padding(.leading)

                Text("Bhuvaneshwari")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.leading)
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 0.07, green: 0.09, blue: 0.3))

            VStack(alignment: .leading, spacing: 28) {
                menuItem(icon: "pencil", label: "Edit my Profile")
                menuItem(icon: "book.closed", label: "See my Bookings")
                menuItem(icon: "trash", label: "Logout")
            }
            .padding(.horizontal)
            .padding(.top, 24)

            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }

    @ViewBuilder
    func menuItem(icon: String, label: String) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.black)

            Text(label)
                .foregroundColor(.black)
                .font(.system(size: 16, weight: .semibold))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                isMenuOpen = false
            }
        }
    }
}


struct HomeView: View {
    @Binding var isMenuOpen: Bool
    @State private var searchText = ""

    let hotels: [Hotel] = [
        Hotel(imageName: "saibaba", name: "The Saibaba Hotel", address: "37 North Boag Road, T - Nagar, Chennai", price: "4.8K"),
        Hotel(imageName: "Residency", name: "A.R Residency", address: "28/19 Ramachandra Street, T - Nagar, Chennai", price: "2.4K"),
        Hotel(imageName: "Accord", name: "Accord Chrome", address: "7 Works Road, Chrompet, Chennai", price: "6.0K"),
        Hotel(imageName: "Fabhotel", name: "FabHotel Vijayalakshmi", address: "98A Sabari Salai, Madipakkam, Chennai", price: "4.3K"),
        Hotel(imageName: "Townhouse", name: "Super Townhouse", address: "35th Street, Nanganallur, Chennai", price: "3.0K"),
        Hotel(imageName: "Hilton", name: "Hilton Chennai", address: "124/1 J.N. Salai, Guindy, Chennai", price: "10K"),
        Hotel(imageName: "ITC", name: "ITC Grand Chola", address: "Mount Road, Guindy, Chennai", price: "10.4K"),
        Hotel(imageName: "Raintree", name: "The Raintree", address: "120 St. Mary's Road, Alwarpet, Chennai", price: "9.4K"),
        Hotel(imageName: "Novotel", name: "Novotel Chennai", address: "Near Boat Club, Anna Salai, Nandanam", price: "8.1K"),
        Hotel(imageName: "Jp", name: "JP Chennai Hotel", address: "1131 Inner Ring Road, Koyambedu, Chennai", price: "6.3K"),
        Hotel(imageName: "Chippy", name: "Chippy Inn", address: "MGR Salai, Kandanchavadi, Perungudi", price: "4.4K"),
        Hotel(imageName: "FabhotelTree", name: "FabHotel HomeTree", address: "17th Street, Anna Nagar East", price: "8.6K")
    ]

    var filteredHotels: [Hotel] {
        if searchText.isEmpty {
            return hotels
        } else {
            return hotels.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.address.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                Button(action: {
                    withAnimation {
                        isMenuOpen.toggle()
                    }
                }) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .foregroundColor(.primary)
                }

                TextField("Search your Location", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                Image(systemName: "magnifyingglass")
                    .font(.title2)
            }
            .padding(.horizontal)

            ScrollView {
                VStack(spacing: 16) {
                    ForEach(filteredHotels) { hotel in
                        VStack {
                            HStack(alignment: .top, spacing: 12) {
                                Image(hotel.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 90, height: 90)
                                    .cornerRadius(10)

                                VStack(alignment: .leading, spacing: 6) {
                                    Text(hotel.name)
                                        .font(.headline)
                                    Text(hotel.address)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("Price: \(hotel.price)")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)

                                    HStack {
                                        Spacer()
                                        NavigationLink(destination: destinationView(for: hotel.name)) {
                                            Text("Book now")
                                                .font(.subheadline)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 20)
                                                .padding(.vertical, 8)
                                                .background(
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                                .cornerRadius(20)
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }

    @ViewBuilder
    func destinationView(for hotelName: String) -> some View {
        Text("Booking View for \(hotelName)")
    }
}


struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
    }
}
