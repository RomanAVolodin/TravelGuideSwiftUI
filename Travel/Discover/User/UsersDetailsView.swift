//
//  UsersDetailsView.swift
//  Travel
//
//  Created by Roman Vol on 07.12.2020.
//

import SwiftUI
import KingfisherSwiftUI

struct UserDetails: Decodable {
    let username, firstName, lastName, profileImage: String
    let followers, following: Int
    let posts: [Post]
}

struct Post: Decodable, Hashable {
    let title, imageUrl, views: String
    let hashtags: [String]
}

class UserDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var details: UserDetails?
    @Published var errorMessage = ""
    
    init(userId: Int) {
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/user?id=\(userId)") else {return}
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            DispatchQueue.main.async {
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Bad Status: \(statusCode)"
                    return
                }
                
                guard let data = data else {return}
                
                do {
                    self.details = try JSONDecoder().decode(UserDetails.self, from: data)
                } catch {
                    print("Failed to decode JSON", error)
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
        }.resume()
    }
}

struct UsersDetailsView: View {
    
    @ObservedObject var vm: UserDetailsViewModel
    
    init(user: User) {
        self.user = user
        self.vm = .init(userId: user.id)
    }
    let user: User
    var body: some View {
        
        ScrollView {
            VStack(spacing: 12) {
                if let details = vm.details {
                    UserDetailsHeaderView(userDetails: details)
                }
                
            
                ForEach(vm.details?.posts ?? [], id: \.self) { post in
                    VStack(alignment: .leading) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                        HStack {
                            KFImage(URL(string: vm.details?.profileImage ?? ""))
                                .resizable()
                                .scaledToFit()
                                .frame(height: 34)
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text(post.title)
                                    .font(.system(size: 13, weight: .semibold))
                                Text(post.views)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.gray)
                            }
                        
                        }.padding(.horizontal, 8)
                        
                        HStack {
                            ForEach(post.hashtags, id: \.self) { hashtag in
                                Text(hashtag)
                                    .foregroundColor(Color(#colorLiteral(red: 0.362208277, green: 0.6089759469, blue: 0.8800933957, alpha: 1)))
                                    .font(.system(size: 14, weight: .semibold))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color(#colorLiteral(red: 0.9028977752, green: 0.9474882483, blue: 0.990914166, alpha: 1)))
                                    .cornerRadius(20)
                            }
                        }.padding(.bottom)
                        .padding(.horizontal, 8)
                       
                    }
                    .background(Color(white: 1))
                    .cornerRadius(12)
                    .shadow(color: .init(white: 0.8), radius: 5, x: 0, y: 4)
                }
                
            }.padding(.horizontal)
            .navigationBarTitle("\(vm.details?.firstName ?? "") \(vm.details?.lastName ?? "")", displayMode: .inline)
    }
    }
}


struct UsersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
        NavigationView {
            UsersDetailsView(user: .init(id: 0, name: "Amy Adams", imageName: "amy"))
        }
        
    }
}
