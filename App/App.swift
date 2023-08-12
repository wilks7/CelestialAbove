//
//  CelestialAboveApp.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import SwiftData

@main
struct CelestialAboveApp: App {
    @StateObject var navigation = NavigationManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigation)
                .modelContainer(SkyData.container)
        }
        #if os(macOS)
        .defaultSize(width: 1000, height: 650)
        #endif
        
        #if os(macOS)
        MenuBarExtra {
            SkiesListView()
                .environmentObject(navigation)
                .modelContainer(SkyData.container)
        } label: {
            Label("Celestial Above", systemImage: "sunrise")
        }
        .menuBarExtraStyle(.window)
        #endif
    }
}
