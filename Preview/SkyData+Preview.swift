//
//  SkyDataPreview.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/11/23.
//

import Foundation
import SwiftData
import SwiftUI


let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: SkyData.schema, configurations: [ModelConfiguration(isStoredInMemoryOnly: true)])
            
        Task {@MainActor in
            let context = container.mainContext
            
            let ny = MockData.NY()
//            ny.events = MockData.events
            context.insert(ny)
        }
        
        return container

    } catch {
        fatalError("Failed to init Preview Container")
    }
}()

struct SkyPreview<Content:View>:View {
    var content: (Sky) -> Content
    var body: some View {
        PreviewContentView<Sky, Content>(content: content)
            .modelContainer(previewContainer)
    }
}

struct ModelPreview<Model: PersistentModel, Content: View>: View {
    
    var content: (Model) -> Content
    
    var body: some View {
        PreviewContentView<Model, Content>(content: content)
            .modelContainer(previewContainer)
    }
    

}

struct PreviewContentView<Model:PersistentModel, Content: View>: View {
    @Query private var models: [Model]
    @State private var delayedPreview = false
    var content: (Model) -> Content

    var body: some View {
        if let model = models.first {
            content(model)
        } else {
            ContentUnavailableView("Could not load model for previews", systemImage: "xmark")
                .opacity(delayedPreview ? 1 : 0 )
                .task {
                    Task {
                        try await Task.sleep(for: .seconds(1))
                        delayedPreview = true
                    }
                }
        }
    }
}
