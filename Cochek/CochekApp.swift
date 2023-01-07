//
//  CochekApp.swift
//  Cochek
//
//  Created by hwikun on 2023/01/07.
//

import SwiftUI

@main
struct CochekApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
