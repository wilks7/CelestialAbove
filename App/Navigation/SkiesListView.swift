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

    private let weatherService = WeatherService()
    
    var body: some View {
        List {
            ForEach(skies) { sky in
                SkyCellView(sky: sky)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background {
                    BackGroundView(sun: sky.weather?.today?.sun, timezone: sky.timezone, time: .now)
                }
                .cornerRadius(16)
                .onTapGesture {
                    withAnimation {
                        self.selected = sky
                    }
                }
                .onAppear {
                    Task {
                        try await sky.fetchData(service: weatherService)
                    }
                }
            }
            .onDelete(perform: delete)
        }
        .listStyle(.plain)
        .overlay{
            if skies.isEmpty {
                ContentUnavailableView("Search for a Night Sky to add", systemImage: "moon.stars")
            }
        }
        #if !os(watchOS)
        .skySearchable(add: add)
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
    
    private func add(key: SkyKey) {
//        let sky = Sky(key: key)
        let sky = Sky(title: key.title, timezone: key.timezone, location: key.location)

        withAnimation {
            context.insert(sky)
        }
    }

    private func delete(_ indexSet: IndexSet) {
        withAnimation {
            indexSet.forEach { index in
                context.delete(skies[index])
            }
        }
    }

}

#Preview {
//    ModelPreview {
        SkiesListView(skies: [], selected: .constant(nil))
//    }
//    SkiesListView()
//        .modelContainer(previewContainer)
}
