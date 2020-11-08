//
//  PopularDestinationsView.swift
//  Travel
//
//  Created by Roman Vol on 08.11.2020.
//

import SwiftUI

struct PopularDestinationsView: View {
    
    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "aifel"),
        .init(name: "Tokyo", country: "Japan", imageName: "japan"),
        .init(name: "New York", country: "USA", imageName: "new_york"),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Popular destinations")
                    .font(.system(size: 12, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }.padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8.0) {
                    ForEach(destinations, id: \.self) { destination in
                        VStack(alignment: .leading, spacing: 0) {
                            
                            Image(destination.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .cornerRadius(5)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 6)
     
                            Text(destination.name)
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.horizontal, 12)
                            Text(destination.country)
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.horizontal, 12)
                                .padding(.bottom, 8)
                                .foregroundColor(.gray)
                        }
                        .background(Color.white)
                            .cornerRadius(5.0)
                        .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 2, x: 0, y: 2)
                            .padding(.bottom)
                    }
                }.padding(.horizontal, 10.0)
            }
        }
    }
}


struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularDestinationsView()
        DiscoverView()
    }
}
