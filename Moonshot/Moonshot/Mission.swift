//
//  Mission.swift
//  Moonshot
//
//  Created by Amruta on 24/09/20.
//  Copyright © 2020 Amruta. All rights reserved.
//

import Foundation

//All we need is Missions(id of mission,lunchDate,desc,array crew of that mission [means array of member name and his role])


struct Mission: Codable, Identifiable {
    
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {//compounded property for date which is optional so that it will return a value or NA directly
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    struct CrewRole: Codable {  //This is called a nested struct, and is simply one struct placed inside of another.
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date? //we might have one,but we also might not have one that's why Optional
    let crew: [CrewRole]
    let description: String
}
