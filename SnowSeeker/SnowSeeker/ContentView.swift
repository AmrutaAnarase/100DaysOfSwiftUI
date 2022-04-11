//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Amruta on 21/01/22.
//

import SwiftUI

struct User: Identifiable {
    var id = "Amruta"
}
struct ContentView: View {
    let resorts:[Resort] = Bundle.main.decode("resorts.json")
    //for search bar
    @State private var searchText = ""
    
    @ObservedObject var favorites = Favorites()
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
 
    var body: some View {
        GeometryReader { fullView in
            NavigationView{
                List(filteredResorts){ resort in
                    NavigationLink{ ResortView(resort: resort)
                    }
                    
                label: {
                    HStack{
                        Image(resort.country)
                            .resizable()
                        //.frame(width: 40, height: 25)
                            .frame(width: fullView.size.width * 0.2, height: fullView.size.height * 0.06)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        VStack(alignment: .leading){
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        .layoutPriority(1)
                        if self.favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(.red)
                        }
                    }
                }
                }
                .navigationTitle("Resorts")
                .searchable(text: $searchText, prompt: "Search for a resort")
                //welcome screen
                WelcomeView()
            }.environmentObject(favorites)
            .phoneOnlyStackNavigationView()
        }
    }
}
extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

