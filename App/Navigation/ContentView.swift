//
//  ContentView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var navigation: NavigationManager
    
    @Query private var skies: [Sky]

    var body: some View {
                
        NavigationSplitView {
            #if os(iOS)
            iOSContentView()
            #else
            SkiesListView()
            #endif
        } detail: {
            detailView
        }
        .onAppear {
            for sky in skies {
                sky.fetchData()
            }
        }
    }
    
    @ViewBuilder
    private var detailView: some View {
        if let selected = navigation.selected {
            SkyView(sky: selected)
                .background(selected.color)
        } else {
            Text(skies.isEmpty ? "Add a Night Sky" : "Select a Sky")
                .font(.largeTitle)
        }
    }
}


#if os(iOS)

struct iOSContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    @Environment(\.modelContext) private var modelContext
    @Query private var skies: [Sky]
    @EnvironmentObject var navigation: NavigationManager

    
    var body: some View {
        if horizontalSizeClass == .compact {
            if let selected = navigation.selected {
                SkiesTabView()
                    .background(selected.color)
            } else {
                SkiesListView()
            }

        } else {
            SkiesListView()
        }
    }
}
#endif


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modelContainer(previewContainer)
            .environmentObject(NavigationManager.shared)
    }
}
