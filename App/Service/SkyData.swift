//
//  Persistence.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import Foundation
import SwiftData

class SkyData {

    static let schema = Schema([
        Sky.self
    ])
    
    static let container = try! ModelContainer(
        for: schema,
        configurations: [ ModelConfiguration(inMemory: false, groupContainer: .identifier("group.app.rifigy.CelestialAbove")) ]
    )

}

extension SkyData {
    static func find(id: String?) -> Sky? {
        guard let id else {return nil}
        let container = Self.container
        let context = ModelContext(container)
        var descriptor = FetchDescriptor<Sky>(predicate: #Predicate{$0.id == id} )
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }
    
    static func find(title: String?) -> Sky? {
        guard let title, !title.isEmpty else {return nil}
        let container = Self.container
        let context = ModelContext(container)
        var descriptor = FetchDescriptor<Sky>(predicate: #Predicate{$0.title == title} )
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }
    
    static func allSkies() -> [Sky] {
        let container = Self.container
        let context = ModelContext(container)
        let descriptor = FetchDescriptor<Sky>()
        let skies = try? context.fetch(descriptor)
        return skies ?? []
    }
}
