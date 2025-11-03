import SwiftUI

struct HiltonimagesView: View {
    @State private var navigateToRooms = false
    @State private var navigateToPlaces = false
    @State private var navigateToConfirmation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerSection
                tabBarSection
                imageGrid
                Spacer(minLength: 10)
                bookNowButton

                // Hidden NavigationLinks triggered by state
                NavigationLink(destination: HiltonView(), isActive: $navigateToRooms) {
                    EmptyView()
                }.hidden()

                NavigationLink(destination: hiltonplacesView(), isActive: $navigateToPlaces) {
                    EmptyView()
                }.hidden()

                NavigationLink(destination: BookingConfirmationView(), isActive: $navigateToConfirmation) {
                    EmptyView()
                }.hidden()
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .background(Color(red: 0.89, green: 0.94, blue: 0.96))
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }

    private var headerSection: some View {
        HStack {
            VStack(spacing: 4) {
                Text("Hilton Chennai")
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
            Spacer()
        }
        .padding(.top, 50)
    }

    private var tabBarSection: some View {
        HStack(spacing: 0) {
            Button(action: {
                navigateToRooms = true
            }) {
                tabButton(title: "Available Rooms", isSelected: false)
            }

            tabButton(title: "Images", isSelected: true)

            Button(action: {
                navigateToPlaces = true
            }) {
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
        VStack(spacing: 12) {
            fullWidthImage("hilton1")

            HStack(spacing: 10) {
                imageView("hilton2")
                imageView("hilton3")
            }

            HStack(spacing: 10) {
                imageView("hilton4")
                imageView("hilton5")
            }

            HStack(spacing: 10) {
                imageView("hilton6")
                imageView("hilton7")
            }
        }
    }

    private func imageView(_ name: String) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: (UIScreen.main.bounds.width - 40) / 2, height: 100)
            .clipped()
            .cornerRadius(10)
    }

    private func fullWidthImage(_ name: String) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width - 30, height: 120)
            .clipped()
            .cornerRadius(10)
    }

    private var bookNowButton: some View {
        VStack {
            Button(action: {
                navigateToConfirmation = true
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
}


struct HiltonimagesView_Previews: PreviewProvider {
    static var previews: some View {
      
            HiltonimagesView()
       
    }
}
