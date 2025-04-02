//
//  DeeperApp.swift
//  Deeper
//
//  Created by Ramunas Jurgilas on 02/04/2025.
//

import SwiftUI
import GoogleMaps

@main
struct DeeperApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        GMSServices.provideAPIKey("AIzaSyAUYbakxIOUOFJN-5E54ygkJW3AxR2VMd0")
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
