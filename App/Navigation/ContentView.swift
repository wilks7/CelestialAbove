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
    @Query private var skies: [Sky]

    var body: some View {
        NavigationSplitView {
            SkiesListView(skies: skies)
            .navigationDestination(for: Sky.self) { sky in
                #if os(iOS)
                if horizontalSizeClass == .compact {
                    SkiesTabView(selected: sky)
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
            let service = WeatherService()
            for sky in skies {
                Task {@MainActor in
                    let weather = try await service.fetchWeather(for: sky)
                    sky.weather = weather
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
