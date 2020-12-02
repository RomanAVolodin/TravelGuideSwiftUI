//
//  PopularDestinationsView.swift
//  Travel
//
//  Created by Roman Vol on 08.11.2020.
//

import SwiftUI
import MapKit

struct PopularDestinationsView: View {
    
    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "aifel", latitude: 48.858525, longitude: 2.294460),
        .init(name: "Tokyo", country: "Japan", imageName: "japan", latitude: 35.680768, longitude: 139.769084),
        .init(name: "New York", country: "USA", imageName: "new_york", latitude: 40.681990, longitude: -73.913967),
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
                        NavigationLink(
                            destination: NavigationLazyView(PopularDestinationDetailsView(destination: destination)),
                            label: {
                                PopularDestinationTile(destination: destination)
                                .padding(.bottom)
                            })
                    }
                }.padding(.horizontal, 10.0)
            }
        }
    }
}

struct DestinationDetails: Decodable {
    let photos: [String]
    let description: String
}

class DestinationDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var destinationDetails: DestinationDetails?
    
    init (name: String) {
        let fixedUrlString = "https://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: fixedUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8) ?? "")
            
            DispatchQueue.main.async {
                do {
                    self.destinationDetails = try JSONDecoder().decode(DestinationDetails.self, from: data)
                } catch {
                    print("Failed to decode JSON", error)
                }
            }
            
        }.resume()
    }
}

struct PopularDestinationDetailsView: View {
    @ObservedObject var vm: DestinationDetailsViewModel
    
    let destination: Destination
    
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions = true
    
    let imagesUrlStrings = ["https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/7156c3c6-945e-4284-a796-915afdc158b5", "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/b1642068-5624-41cf-83f1-3f6dff8c1702", "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/6982cc9d-3104-4a54-98d7-45ee5d117531",
    "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/2240d474-2237-4cd3-9919-562cd1bb439e"]
    
    init(destination: Destination) {
        self.destination = destination
        
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)))
        
        self.vm = .init(name: destination.name)
            
    }
    
    
    var body: some View {
        ScrollView {
            
            if let photos = vm.destinationDetails?.photos {
                DestinationHeaderContainer(imageUrlStrings: photos)
                    .frame(height: 250)
            }
            
            VStack(alignment: .leading){
                Text(destination.name)
                    .font(.system(size: 18, weight: .bold))
                Text(destination.country)
                
                HStack {
                    ForEach(0..<5, id: \.self) { num in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }.padding(.top, 2)
                
                
                HStack {
                    Text(vm.destinationDetails?.description ?? "")
                        .padding(.top, 4)
                        .font(.system(size: 14))
                    Spacer()
                }
            }
            .padding(.horizontal)
            
            HStack{
                Text("Location")
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                Button(action: {
                    isShowingAttractions.toggle()
                }, label: {
                    Text("\(isShowingAttractions ? "Hide" : "Show") attractions")
                        .font(.system(size: 12, weight: .semibold))
                })
                
                Toggle("", isOn: $isShowingAttractions)
                    .labelsHidden()
                
            }.padding(.horizontal)
            
            
            Map(coordinateRegion: $region, annotationItems: isShowingAttractions ?  attractions : []) { attraction in
                
//                MapMarker(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude), tint: .red)
                MapAnnotation(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude)) {
                    CustomMapAnnotation(attraction: attraction)
                }
                
            }.frame(height: 350)
            
        
        }.navigationBarTitle(destination.name, displayMode: .inline)
    }
    
    let attractions: [Attraction] = [
        .init(name: "Eifel tower", latitude: 48.858525, longitude: 2.294460, imageName: "aifel"),
        .init(name: "Eifel tower2", latitude: 48.861433, longitude: 2.291810, imageName: "japan"),
    ]
}

struct Attraction: Identifiable {
    let id = UUID().uuidString
    
    let name: String
    let latitude, longitude: Double
    let imageName: String
}

struct CustomMapAnnotation: View {
    let attraction: Attraction
    
    var body: some View {
        VStack {
            Image(attraction.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 60)
                .clipped()
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.3)))
                )
            
            Text(attraction.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.3)))
                )
            
        }.shadow(radius: 5)
    }
}

struct PopularDestinationTile: View {
    
    let destination: Destination
    
    var body: some View {
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
                .foregroundColor(Color(.label))
            Text(destination.country)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
        }
        .asTile()
    }
}

struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "aifel", latitude: 48.869942, longitude: 2.344626))
        }
        
        DiscoverView()
        PopularDestinationsView()
    }
}
