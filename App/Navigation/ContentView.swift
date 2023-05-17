//
//  ContentView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var navigation: NavigationManager
    
    @FetchRequest(fetchRequest: Sky.sorted, animation: .default)
    private var skies: FetchedResults<Sky>

    var body: some View {
        NavigationSplitView {
            #if os(iOS)
            iOSView
            #else
            SkiesListView()
            #endif
        } detail: {
            if let selected = navigation.selected {
                SkyView(sky: selected)
                    .background(selected.color)
            }
        }
        .onAppear {
            for sky in skies {
                sky.fetchData()
            }
        }
    }
    
    #if os(iOS)
    @ViewBuilder
    var iOSView: some View {
        if horizontalSizeClass == .compact {
            if let selected = navigation.selected {
                SkiesTabView(skies: skies, selected: selected)
                    .background(selected.color)
            } else {
                SkiesListView()
            }
        } else {
            SkiesListView()
        }
    }
    #endif
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, skyData.context)
            .environmentObject(NavigationManager.shared)
    }
}
