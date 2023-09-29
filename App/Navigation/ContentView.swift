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
                #if os(iOS)
                if horizontalSizeClass == .compact {
                    SkiesTabView(skies: skies, selected: sky)
                } else {
                    SkyGridView(sky: sky)
                }
                #else
                SkyGridView(sky: sky)
                #endif
            }
        } detail: {
            ContentUnavailableView(
                skies.isEmpty ? "Add a Night Sky" : "Select a Sky",
                systemImage: "moon.stars"
            )
        }
        .onAppear {
            for sky in skies {
                Task {
                    await sky.fetchData(service:service)
                    try? context.save()
                }
            }
        }

    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
