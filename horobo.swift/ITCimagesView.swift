import SwiftUI

struct ITCimagesView: View {
    @State private var navigateToRooms = false
    @State private var navigateToPlaces = false
    @State private var navigateToConfirmation = false

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    headerSection
                    tabBarSection
                    imageGrid
                    Spacer(minLength: 10)
                    bookNowButton
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .background(Color(red: 0.89, green: 0.94, blue: 0.96))
            .ignoresSafeArea()
            .navigationBarHidden(true)

            // Navigation Links (Hidden)
            NavigationLink(destination: ITCView(), isActive: $navigateToRooms) {
                EmptyView()
            }
            .hidden()

            NavigationLink(destination: ITCplacesView(), isActive: $navigateToPlaces) {
                EmptyView()
            }
            .hidden()
            
            NavigationLink(destination: BookingConfirmationView(), isActive: $navigateToConfirmation) {
                EmptyView()
            }
            .hidden()
        }
    }

    private var headerSection: some View {
        HStack {
            VStack(spacing: 4) {
                Text("ITC Grand Chola")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.07, green: 0.08, blue: 0.3))

                HStack(spacing: 4) {
                    Text("4.7")
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
        VStack(spacing: 15) {
            HStack(spacing: 10) {
                imageView("itc1")
                imageView("itc2")
            }

            fullWidthImage("itc3")

            HStack(spacing: 10) {
                imageView("itc4")
                imageView("itc5")
            }

            HStack(spacing: 10) {
                imageView("itc6")
                imageView("itc7")
            }
        }
    }

    private func imageView(_ name: String) -> some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: (UIScreen.main.bounds.width - 40) / 2, height: 150)
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

struct ITCimagesView_Previews: PreviewProvider {
    static var previews: some View {
        ITCimagesView()
    }
}
