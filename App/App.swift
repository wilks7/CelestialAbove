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
    @StateObject var navigation = NavigationManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigation)
                .environment(\.managedObjectContext, skyData.container.viewContext)
        }
    }
}
