//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Amruta on 24/01/22.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @State private var selectedFacility: Facility?
    @EnvironmentObject var favorites: Favorites
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 0){
                Image(resort.id)
                    .resizable()
                    .scaledToFit()
                HStack {
                    ResortDetailsView(resort: resort)
                    SkiDetailsView(resort: resort)
                }.padding(.vertical)
                .background(Color.primary.opacity(0.1))
                Group{
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    //format is A,B,C
                    //                    Text(resort.facilities.joined(separator: ""))
                    //                        .padding(.vertical)
                    //Format is A,B and C
                    //                    Text(resort.facilities, format: .list(type: .and))
                    //                        .padding(.vertical)
                    //                    //above code is replaced with below because we want use icons instead of text
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility}}}
                    .padding(.vertical)
                }
                .padding(.horizontal)
               
            }
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if self.favorites.contains(self.resort) {
                    self.favorites.remove(self.resort)
                } else {
                    self.favorites.add(self.resort)
                }
            }
            .padding()        }
        .navigationTitle("\(resort.name),\(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
       
    }
}
//@State property to the alert(item:) modifier – it needs to be something that conforms to the Identifiable protocol.if we set selectedFacility to some string an alert should appear, but if we then change it to a different string SwiftUI needs to be able to see that the value changed.
extension String: Identifiable {
    public var id: String { self }
}
struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
