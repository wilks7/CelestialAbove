//
//  ContentView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import SwiftData
import WeatherKit

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.modelContext) private var context
    
    @Query private var skies: [Sky]
        
    @State private var selected: Sky? = nil
    
    private let service = WeatherService()

    
    var body: some View {
        NavigationSplitView {
            SkiesListView(skies: skies, selected: $selected)
            .navigationDestination(item: $selected) { sky in
                SkyGridView(sky: sky)
            }
        } detail: {
            if let selected {
                SkyGridView(sky: selected)
            } else {
                ContentUnavailableView(
                    skies.isEmpty ? "Add a Night Sky" : "Select a Sky",
                    systemImage: "moon.stars"
                )
            }
        }
    }
}
