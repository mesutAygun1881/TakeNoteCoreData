//
//  TakeNoteApp.swift
//  TakeNote
//
//  Created by Mesut Aygün on 25.05.2021.
//

import SwiftUI

@main
struct TakeNoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
