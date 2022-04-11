//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Amruta on 17/04/21.
//

import SwiftUI
import CoreData

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
   
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            Text("\(singer.wrappedFirstName),\(singer.wrappedLastName)")
        }
    }
    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate:  NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
}


