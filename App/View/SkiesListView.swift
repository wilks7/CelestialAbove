//
//  SkiesListView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI

struct SkiesListView: View {
    @Environment(\.managedObjectContext) private var context

    @FetchRequest(fetchRequest: Sky.sorted, animation: .default)
    private var skies: FetchedResults<Sky>

    var body: some View {
        NavigationStack {
            List {
                ForEach(skies) { sky in
                    NavigationLink {
                        SkyView(sky: sky)
                    } label: {
                        SkyCell(sky: sky)
                    }
                    .task {
                        await sky.fetchForecast()
                    }
                }
                .onDelete(perform: deleteSkies)
            }
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

        }
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
            .environment(\.managedObjectContext, skyData.context)
    }
}
