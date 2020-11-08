//
//  CategoryDetailView.swift
//  Travel
//
//  Created by Roman Vol on 08.11.2020.
//

import SwiftUI
import KingfisherSwiftUI
import SDWebImageSwiftUI

class CategoryDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    
    init() {
        
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/category?name=art") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                guard let data = data else { return }
                
                do {
                    self.places = try JSONDecoder().decode([Place].self, from: data)
                } catch {
                    print("Failed to decode JSON", error)
                    self.errorMessage = error.localizedDescription
                }
                
                self.isLoading = false
            }
            
        }.resume()
        
    }
    
}


struct CategoryDetailsView: View {
    
//    @State var isLoading = true
    @ObservedObject var vm = CategoryDetailsViewModel()
    
    var body: some View {
        ZStack {
            if vm.isLoading {
                VStack {
                    ActivityIndicatorView()
                    Text("Loading...")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .semibold))
                }
                .padding()
                .background(Color.black)
                .cornerRadius(8)
                
            } else {
                ZStack {
                    Text(vm.errorMessage)
                    ScrollView {
                        ForEach(vm.places, id: \.self) { place in
                            VStack(alignment: .leading, spacing: 0) {
                                
                                WebImage(url: URL(string: place.thumbnail))
                                    .resizable()
                                    .transition(.fade(duration: 1))
                                    .scaledToFill()

                                Text(place.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .padding()
                                   
                            }.asTile()
                            .padding()
                        }
                        
                    }
                }
            
            }
        }.navigationBarTitle("Category", displayMode: .inline)
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailsView()
    }
}
