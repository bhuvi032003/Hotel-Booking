//
//  NearbyPlacesView.swift
//  HoRoBo
//
//  Created by SAIL on 09/07/25.
//

import SwiftUI

struct NearbyPlacesView: View {
    
    let prices = (Manager.shared.hotelData?.nearbyPlaces)

    

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(prices ?? [], id: \.self) { urlString in
                    
                   Text(urlString)
                        .foregroundColor(Color.red)
                        .font(.headline)
                        
                        
//                    if let url = URL(string: ServiceAPI.baseURL+urlString) {
//                        AsyncImage(url: url) { phase in
//                            switch phase {
//                            case .empty:
//                                ProgressView()
//                                    .frame(maxWidth: .infinity, minHeight: 200)
//                            case .success(let image):
//                                image
//                                    .resizable()
//                                    .scaledToFit()
//                                    .cornerRadius(10)
//                                    .padding(.horizontal)
//                            case .failure:
//                                Image(systemName: "photo")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .foregroundColor(.gray)
//                                    .frame(height: 200)
//                                    .padding(.horizontal)
//                            @unknown default:
//                                EmptyView()
//                            }
//                        }
//                    }
                }
            }
            .padding(.top)
        }
        .navigationTitle("Images")
    }
}
