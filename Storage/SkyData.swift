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
        configurations: [
            ModelConfiguration(
                isStoredInMemoryOnly: false
            )
//            groupContainer: .identifier("group.app.rifigy.CelestialAbove")
//            )
        ]
    )
    
//    let container: ModelContainer
    let context: ModelContext
    
    init(){
        self.context = ModelContext(Self.container)
    }
    static let shared = SkyData()


}

import CoreLocation
extension SkyData {
    
    func sky(at location: CLLocation?) -> Sky? {
        guard let location else {
            var descriptor = FetchDescriptor<Sky>(predicate: #Predicate { $0.currentLocation} )
            descriptor.fetchLimit = 1
            return try? context.fetch(descriptor).first
        }
        
        let id = location.id
        let predicate: Predicate<Sky> = #Predicate{ $0.id == id }
        var descriptor = FetchDescriptor<Sky>(predicate: predicate)
        descriptor.fetchLimit = 1

        return try? context.fetch(descriptor).first
    }
    

    
    func skies(for identifiers: [String]) -> [Sky] {
        return skies()
//        let predicate: Predicate<Sky> = #Predicate{ identifiers.contains($0.id) }
//        var descriptor = FetchDescriptor<Sky>(predicate: predicate )
//        do {
//            let skies = try context.fetch(descriptor)
//            return skies
//        } catch {
//            print(error)
//            return []
//        }
        
    }
    
    func skies() -> [Sky] {
        let descriptor = FetchDescriptor<Sky>()
        let skies = try? context.fetch(descriptor)
        return skies ?? []
    }
    
    func sky(for id: Sky.ID) -> Sky? {
        let predicate: Predicate<Sky> = #Predicate{ $0.id == id }
        var descriptor = FetchDescriptor<Sky>(predicate: predicate)
        descriptor.fetchLimit = 1

        return try? context.fetch(descriptor).first

    }
    
    func sky(named title: String?) -> Sky? {
        guard let title, !title.isEmpty else {return nil}
        
        let predicate: Predicate<Sky> = #Predicate{$0.title == title}
        var descriptor = FetchDescriptor<Sky>(predicate: predicate)
        descriptor.fetchLimit = 1

        return try? context.fetch(descriptor).first

    }

}
