//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by hicham fakir on 3/11/2026.
//

import SwiftUI
import CoreData

@main
struct LittleLemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
