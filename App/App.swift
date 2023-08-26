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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(SkyData.container)
        }
        #if os(macOS)
        .defaultSize(width: 1000, height: 650)
        #endif
        
        #if os(macOS)
        SkyMenuBar()
        #endif
    }
}
