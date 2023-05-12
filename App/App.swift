//
//  CelestialAboveApp.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

@main
struct CelestialAboveApp: App {
    let skyData = SkyData.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, skyData.container.viewContext)
        }
    }
}
