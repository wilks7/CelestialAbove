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
    var skies: [Sky]

    var body: some View {
        List {
            ForEach(skies) { sky in
                SkyCellView(sky: sky)
            }
            .onDelete(perform: delete)
        }
        .listStyle(.plain)
        #if !os(watchOS)
        .skySearchable()
        #endif
        #if os(iOS)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
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
        SkiesListView(skies: [$0])
    }
//    SkiesListView()
//        .modelContainer(previewContainer)
}
