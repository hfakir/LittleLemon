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
    @AppStorage("kIsLoggedIn") var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                Home()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                Onboarding()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
