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
    let skies: [Sky]

    @Binding var selected: Sky?
    var animationNamespace: Namespace.ID

    var body: some View {
        List {
            ForEach(skies) { sky in
                SkyCellView(sky: sky)
                .background(
                    sky.color

                )
                .matchedGeometryEffect(id: sky.id, in: animationNamespace)
                .cornerRadius(16)
                .onTapGesture {
                    select(sky)
                }
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
        .clipped(antialiased: false)

    }
    
    private func select(_ sky: Sky) {
        withAnimation {
            self.selected = sky
        }
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
        SkiesListView(skies: [$0], selected: .constant(nil), animationNamespace: Namespace().wrappedValue)
    }
//    SkiesListView()
//        .modelContainer(previewContainer)
}
