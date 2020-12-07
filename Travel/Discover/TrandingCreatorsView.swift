//
//  TrandingCreatorsView.swift
//  Travel
//
//  Created by Roman Vol on 08.11.2020.
//

import SwiftUI

struct TrandingCreatorsView: View {
    
    let users: [User] = [
        .init(id: 0, name: "Amy Adams", imageName: "amy"),
        .init(id: 1, name: "Katherine Solody", imageName: "kathy"),
        .init(id: 2, name: "Smith", imageName: "sam"),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Popular places to eat")
                    .font(.system(size: 12, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }.padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 12.0) {
                    ForEach(users, id: \.self) { user in
                        NavigationLink(
                            destination: NavigationLazyView(UsersDetailsView(user: user)),
                            label: {
                                DiscoverUserView(user: user)
                            })
                    }
                }.padding(.horizontal, 10)
            }
        }
    }
}


struct DiscoverUserView: View {
    let user: User
    var body: some View {
        VStack {
            Image(user.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(60)
            Text(user.name)
                .font(.system(size: 11, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }.frame(width: 60)
            .shadow(color: .gray, radius: 4, x: 0, y: 2)
            .padding(.bottom, 10)
    }
}

struct TrandingCreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        TrandingCreatorsView()
        DiscoverView()
    }
}
