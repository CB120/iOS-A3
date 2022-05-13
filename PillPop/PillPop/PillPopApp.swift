//
//  PillPopApp.swift
//  PillPop
//
//  Created by Joanna Pritt on 14/5/2022.
//

import SwiftUI

@main
struct PillPopApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
