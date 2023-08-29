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
    @Query private var skies: [Sky]

    var body: some View {
        List {
            ForEach(skies) { sky in
                ZStack {
                    NavigationLink(value: sky) {
                        EmptyView()
                    }.opacity(0.0)
                    SkyCellView(title: sky.title ?? sky.id, timezone: sky.timezone) {
                        VStack(alignment: .trailing) {
                            PercentView(percent: sky.weather?.today?.percent ?? 0, size: 42)
                        }
                    } bottomTrailing: {
                        VStack(alignment: .trailing, spacing: 0) {
                            PlanetView(celestial: sky.events.first?.title ?? "Mars")
                                .frame(width: 30, height: 30)
                            Text(sky.events.first?.nextTime ?? "--")
                        }
                    } bottomLeading: {
                        VStack{
                            VStack(alignment: .leading) {
                                Image(systemName: sky.weather?.hour?.symbolName ?? "cloud")
                                Text("--")
                                    .shadow(color: .red, radius: 20)
                            }
                        }
                    }

//                    SkyCellView<Percent, CelestialEvents, Cloud>(sky: sky)
                }
//                SkyCellView<Percent, CelestialEvents, Cloud>(sky: sky)
//                .onTapGesture {
//                    selection = sky
//                }
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

#Preview {
    SkiesListView()
        .modelContainer(previewContainer)
}
