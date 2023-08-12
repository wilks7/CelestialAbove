//
//  SkiesListView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import SwiftData

struct SkiesListView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var navigation: NavigationManager
    @Query private var skies: [Sky]

    var body: some View {
            List {
                ForEach(skies) { sky in
                    #if os(watchOS)
                    NavigationLink(destination: SkyView(sky: sky)) {
                        SkyCellView<Percent, CelestialEvents, Cloud>(sky: sky)
                    }
                    #else
                    SkyCellView<Percent, CelestialEvents, Cloud>(sky: sky)
                    .onTapGesture {
                        navigation.navigate(to: sky)
                    }
                    #endif
                }
                .onDelete(perform: delete)
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

    
    private func delete(_ indexSet: IndexSet) {
        withAnimation {
            indexSet.forEach { index in
                context.delete(skies[index])
            }
            try? context.save()
        }
    }

}

struct SkiesListView_Previews: PreviewProvider {
    static var previews: some View {
        SkiesListView()
            .modelContainer(previewContainer)
            .environmentObject(NavigationManager.shared)
    }
}
