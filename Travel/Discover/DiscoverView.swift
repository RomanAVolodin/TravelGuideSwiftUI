//
//  ContentView.swift
//  Travel
//
//  Created by Roman Vol on 06.11.2020.
//

import SwiftUI

extension Color {
    static let discoverBackground = Color(.init(white: 0.95, alpha: 1))
}

struct DiscoverView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        NavigationView {
            
            ZStack {
               LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.6934161186, blue: 0.1322508156, alpha: 1)), Color(#colorLiteral(red: 0.8925110698, green: 0.2886781096, blue: 0, alpha: 1))]), startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
                
                Color.discoverBackground
                    .offset(y: 400)
                
                ScrollView {
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Where do you want to go ?")
                        Spacer()
                    }.font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.init(white: 1, alpha: 0.3)))
                    .cornerRadius(12)
                    .padding(16)
                    
                    DiscoverCategoriesView()
                    
                    VStack {
                        PopularDestinationsView()
                        
                        PopularRestaurantsView()
                        
                        TrandingCreatorsView()
                        
                    }.background(Color.discoverBackground)
                    .cornerRadius(16)
                    .padding(.top, 16)
                
                }
            }
            .navigationTitle("Discover")
 
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}

