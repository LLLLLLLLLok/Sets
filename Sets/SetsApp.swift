//
//  SetsApp.swift
//  Sets
//
//  Created by f1235791 on 17/11/2023.
//

import SwiftUI

@main
struct SetsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
