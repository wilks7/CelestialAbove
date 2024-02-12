//
//  SkyMenuBar.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/26/23.
//

import SwiftUI
import SwiftData

struct SkyMenuBar: Scene {
    
    @Query private var skies: [Sky]
    @State private var selection: Sky?
    
    var body: some Scene {
        MenuBarExtra {
            SkiesListView(skies: skies, selected: $selection)
        } label: {
            Label("Celestial Above", systemImage: "sunrise")
        }
        .menuBarExtraStyle(.window)
    }

}

//#Preview {
//    SkyMenuBar()
//        .modelContainer(previewContainer)
//
//}
