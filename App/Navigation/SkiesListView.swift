//
//  SkiesListView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import SwiftData
import WeatherKit

struct SkiesListView: View {
    @Environment(\.modelContext) private var context
    let skies: [Sky]

    @Binding var selected: Sky?

    var body: some View {
        List {
            ForEach(skies) { sky in
                SkyCellView(sky: sky)
                .background(sun: sky.weather?.today?.sun, timezone: sky.timezone, time: .now)
                .cornerRadius(16)
                .onTapGesture {
                    withAnimation {
                        self.selected = sky
                    }
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(.plain)
        .overlay{
            if skies.isEmpty {
                ContentUnavailableView("Search for a Night Sky to add",systemImage: "moon.stars")
            }
        }
        #if !os(watchOS)
        .skySearchable()
        #endif
        #if os(iOS)
        .toolbar {
            if !skies.isEmpty {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        #endif
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
    ModelPreview {
        SkiesListView(skies: [$0], selected: .constant(nil))
    }
//    SkiesListView()
//        .modelContainer(previewContainer)
}
