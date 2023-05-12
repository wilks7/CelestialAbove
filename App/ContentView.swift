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

    @FetchRequest(fetchRequest: Sky.sorted, animation: .default)
    private var skies: FetchedResults<Sky>
    @State private var selected: Sky?

    var body: some View {
        ZStack {
            SkiesListView(selected: $selected)
            if let selected {
                SkiesTabView(skies: skies, selected: $selected)
            }
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, skyData.context)
    }
}
