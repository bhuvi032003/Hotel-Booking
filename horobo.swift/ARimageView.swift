import SwiftUI

struct ARimageView: View {
    @State private var navigateToBooking = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                // Header
                VStack(spacing: 4) {
                    Text("A.R Residency")
                        .font(.headline)
                        .foregroundColor(.black)

                    HStack(spacing: 4) {
                        Text("4.5")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        ForEach(0..<4, id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.footnote)
                        }
                        Image(systemName: "star.leadinghalf.filled")
                            .foregroundColor(.yellow)
                            .font(.footnote)
                    }
                }
                .padding(.top)

                // Tabs
                HStack {
                    Spacer()
                    NavigationLink(destination: ARResidencyView()) {
                        Text("Available Rooms")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Text("Images")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    Spacer()
                    NavigationLink(destination: ARplacesView()) {
                        Text("Nearby Places")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                // Image Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(imageNames, id: \.self) { name in
                        Image(name)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: (UIScreen.main.bounds.width - 48) / 2, height: 120)
                            .clipped()
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)

                // Hidden NavigationLink
                NavigationLink(destination: BookingConfirmationView(), isActive: $navigateToBooking) {
                    EmptyView()
                }

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
                        .cornerRadius(12)
                        .padding(.horizontal, 45)
                }

                Spacer(minLength: 16)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }

    // Image asset names
    private var imageNames: [String] {
        ["Arimg1", "Arimg2", "Arimg3", "Arimg4", "Arimg5", "Arimg7", "Arimg6", "Arimg8"]
    }
}

struct ARimageView_Previews: PreviewProvider {
    static var previews: some View {
       
            ARimageView()
        
    }
}
