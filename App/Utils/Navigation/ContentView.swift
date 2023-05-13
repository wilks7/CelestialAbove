//
//  ContentView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var navigation: NavigationManager
    
    @FetchRequest(fetchRequest: Sky.sorted, animation: .default)
    private var skies: FetchedResults<Sky>

    var body: some View {
        NavigationSplitView {
            #if os(iOS)
            if let selected = navigation.selected {
                SkiesTabView(skies: skies, selected: selected)
            } else {
                SkiesListView()
            }
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

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, skyData.context)
            .environmentObject(NavigationManager.shared)
    }
}
