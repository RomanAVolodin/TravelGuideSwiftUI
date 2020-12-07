//
//  UserDetailsHeaderView.swift
//  Travel
//
//  Created by Roman Vol on 07.12.2020.
//

import SwiftUI
import KingfisherSwiftUI

struct UserDetailsHeaderView: View {
    let userDetails: UserDetails
    
    var body: some View {
        KFImage(URL(string: userDetails.profileImage))
            .resizable()
            .scaledToFit()
            .frame(width: 90)
            .clipShape(Circle())
            .shadow(radius: 10)
            .padding(.horizontal)
            .padding(.top)
        
        Text("\(userDetails.firstName) \(userDetails.lastName)")
            .font(.system(size: 14, weight: .semibold))
        
        HStack {
            Text("@\(userDetails.username) •")

            Image(systemName: "hand.thumbsup.fill")
                .font(.system(size: 10, weight: .semibold, design: .default))
            
            Text("21567")
        }.font(.system(size: 12, weight: .regular, design: .default))
       
        Text("Long text abiout persona Long text abiout persona")
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(Color(.lightGray))

        FollowersView(userDetails: userDetails)
        FollowButtons()
    }
}

struct FollowersView: View {
    let userDetails: UserDetails
    
    var body: some View {
        HStack(spacing: 12) {
            VStack {
                Text("56")
                    .font(.system(size: 13, weight: .semibold))
                Text("Followers")
                    .font(.system(size: 9, weight: .regular))
            }
            Spacer()
                .frame(width: 0.1, height: 15)
                .background(Color(.lightGray))
            
            VStack {
                Text("778")
                    .font(.system(size: 13, weight: .semibold))
                Text("Following")
                    .font(.system(size: 9, weight: .regular))
            }
        }
    }
}

struct FollowButtons: View {
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {}, label: {
                HStack {
                    Spacer()
                    Text("Follow")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical, 8)
                .background(Color.orange)
                .cornerRadius(100)
            })
            
            Button(action: {}, label: {
                HStack {
                    Spacer()
                    Text("Contact")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.vertical, 8)
                .background(Color(white: 0.8))
                .cornerRadius(100)
            })
        }
    }
}

struct UserDetailsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
       DiscoverView()
    }
}
