//
//  ContentView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Query private var skies: [Sky]

    var body: some View {
        NavigationSplitView {
            SkiesListView()
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
            for sky in skies {
                sky.fetchData()
            }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
