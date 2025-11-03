import SwiftUI

struct HotelPinEntryView: View {
    @State private var hotelPin = ""
    @State private var showSuccess = false

    var body: some View {
        ZStack {
            
            Color(red: 0.89, green: 0.94, blue: 0.96)
                .ignoresSafeArea()

            VStack {
                Spacer()

                VStack(spacing: 20) {
                    Text("Enter Your Hotel Pin")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("To Continue!!")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    TextField("Enter Hotel pin", text: $hotelPin)
                        .padding()
                        .frame(width: 260)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }

                Spacer()

                
                Button(action: {
                    withAnimation(.easeInOut) {
                        showSuccess = true
                    }
                }) {
                    Text("Submit")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(red: 9/255, green: 7/255, blue: 71/255))
                        .cornerRadius(20)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
            }
            
            .blur(radius: showSuccess ? 5 : 0)

            
            if showSuccess {
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.green)
                        .shadow(radius: 5)

                    Text("Details Updated Successfully!!")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .transition(.scale)
            }
        }
    }
}

struct HotelPinEntryView_Previews: PreviewProvider {
    static var previews: some View {
        HotelPinEntryView()
    }
}
