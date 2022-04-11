//
//  CoreDataProject1PracApp.swift
//  CoreDataProject1Prac
//
//  Created by Amruta on 17/04/21.
//

import SwiftUI

@main
struct CoreDataProject1PracApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
