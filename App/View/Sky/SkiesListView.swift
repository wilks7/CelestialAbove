//
//  SkiesListView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct SkiesListView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var navigation: NavigationManager
    
    @FetchRequest(fetchRequest: Sky.sorted, animation: .default)
    private var skies: FetchedResults<Sky>

    var body: some View {
            List {
                ForEach(skies) { sky in
                    SkyCell(sky: sky)
                    .onTapGesture {
                        navigation.navigate(to: sky)
                    }
                }
                .onDelete(perform: deleteSkies)
            }
            .listStyle(.plain)
            #if !os(watchOS)
            .skySearchable()
            #endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
            }
            .navigationTitle("Night Skies")

    }

    
    private func deleteSkies(offsets: IndexSet) {
        withAnimation {
            offsets.map { skies[$0] }.forEach(context.delete)
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }

}

struct SkiesListView_Previews: PreviewProvider {
    static var previews: some View {
        SkiesListView()
            .environmentObject(NavigationManager.shared)
            .environment(\.managedObjectContext, skyData.context)
    }
}
