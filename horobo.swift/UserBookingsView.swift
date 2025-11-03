//
//  UserBookingsView.swift
//  HoRoBo
//
//  Created by SAIL on 03/07/25.
//

import SwiftUI

struct UserBookingsView: View {
    var body: some View {
        ZStack {
            Color(red: 0.88, green: 0.96, blue: 1.0)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    Image(systemName: "book.closed")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                    Text("Your Bookings")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
                .padding(.leading)

                // Booking Cards Scroll View
                ScrollView {
                    VStack(spacing: 16) {
                        // A.R Residency Booking
                        BookingCard(roomNumber: "107",
                                  hotelName: "A.R Residency",
                                  checkinDate: "17-06-2025",
                                  iconName: "door")
                        
                        // Paramount Inn Booking
                        BookingCard(roomNumber: "312",
                                  hotelName: "Paramount Inn",
                                  checkinDate: "05-05-2025",
                                  iconName: "building")
                        
                        // Hilton Chennai Booking
                        BookingCard(roomNumber: "804",
                                  hotelName: "Hilton Chennai",
                                  checkinDate: "22-03-2025",
                                  iconName: "building.2")
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding(.top, 30)
        }
    }
}

struct BookingCard: View {
    var roomNumber: String
    var hotelName: String
    var checkinDate: String
    var iconName: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.leading)

            VStack(alignment: .leading, spacing: 8) {
                Text("Room no.\(roomNumber)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)

                Text("at ")
                    .foregroundColor(.black)
                    .font(.system(size: 14)) +
                Text(hotelName)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.indigo)

                Text("checkin date: ")
                    .foregroundColor(.black)
                    .font(.system(size: 14)) +
                Text(checkinDate)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.indigo)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

// Preview
struct UserBookingsView_Previews: PreviewProvider {
    static var previews: some View {
        UserBookingsView()
    }
}
