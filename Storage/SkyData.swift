//
//  Persistence.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import Foundation
import SwiftData

class SkyData {
    static let schema = Schema([ Sky.self ])
    
    static let container = try! ModelContainer(
        for: schema,
        configurations: [
            ModelConfiguration(
                isStoredInMemoryOnly: false
            )
//            groupContainer: .identifier("group.app.rifigy.CelestialAbove")
//            )
        ]
    )
    
    let context: ModelContext
    
    init(){
        self.context = ModelContext(Self.container)
    }
    static let shared = SkyData()

}

extension SkyData: SkyStorage {
    func sky(for id: Sky.ID) -> Sky? {
        let predicate: Predicate<Sky> = #Predicate{ $0.id == id }
        var descriptor = FetchDescriptor<Sky>(predicate: predicate)
        descriptor.fetchLimit = 1
        
        return try? context.fetch(descriptor).first

    }
    
    func skies(for identifiers: [String]) -> [Sky] {
        let predicate: Predicate<Sky> = #Predicate{ identifiers.contains($0.id) }
        let descriptor = FetchDescriptor<Sky>(predicate: predicate )
        let skies = try? context.fetch(descriptor)
        
        return skies ?? []
    }
    
    func allSkies() -> [Sky] {
        let descriptor = FetchDescriptor<Sky>()
        let skies = try? context.fetch(descriptor)
        
        return skies ?? []
    }
    

}

//    func sky(named title: String?) -> Sky? {
//        guard let title, !title.isEmpty else {return nil}
//
//        let predicate: Predicate<Sky> = #Predicate{$0.title == title}
//        var descriptor = FetchDescriptor<Sky>(predicate: predicate)
//        descriptor.fetchLimit = 1
//
//        return try? context.fetch(descriptor).first
//
//    }
