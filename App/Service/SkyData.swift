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
        configurations: [ ModelConfiguration(inMemory: false) ]
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

//struct SkyData {
//    static let shared = SkyData()
//    static var sharedStore: URL {
//        FileManager.default
//            .containerURL(forSecurityApplicationGroupIdentifier: "group.app.rifigy.CelestialAbove")!
//            .appendingPathComponent("SkyData.sqlite")
//    }
//    let container: NSPersistentCloudKitContainer
//    
//    var context: NSManagedObjectContext { container.viewContext }
//
//    init(inMemory: Bool = false) {
//        container = NSPersistentCloudKitContainer(name: "SkyData")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        } else {
//            container.persistentStoreDescriptions.first!.url = Self.sharedStore
//        }
//        container.loadPersistentStores(completionHandler: handleError)
//        container.viewContext.automaticallyMergesChangesFromParent = true
//    }
//    
//    private func handleError(description: NSPersistentStoreDescription, error: Swift.Error?) -> Void {
//        if let error = error as NSError? {
//            /*
//             * The parent directory does not exist, cannot be created, or disallows writing.
//             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//             * The device is out of space.
//             * The store could not be migrated to the current model version.
//             */
//            fatalError("Unresolved error \(error), \(error.userInfo)")
//        }
//    }
//    
//    enum Error: Swift.Error {
//        case load, save, add, delete, notFound, badID
//    }
//}
//
//extension Sky {
//    static let request: NSFetchRequest<Sky> = NSFetchRequest<Sky>(entityName: "Sky")
//    static let sorted: NSFetchRequest<Sky> = {
//        let request = NSFetchRequest<Sky>(entityName: "Sky")
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \Sky.currentLocation, ascending: false)]
//        return request
//    }()
//}
//
//extension SkyData {
//    func skies()->[Sky] {
//        do {
//            return try context.fetch(Sky.sorted)
//        } catch {
//            print(error)
//            return []
//        }
//    }
//    
//    func findSky(withId id: String) throws -> Sky {
//        guard let uuid = UUID(uuidString: id) else {
//            throw Error.badID
//        }
//        return try findSky(withId: uuid)
//    }
//    
//    func findSky(withId id: UUID) throws -> Sky {
//        let request: NSFetchRequest<Sky> = Sky.request
//        request.fetchLimit = 1
//        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
//        
//        do {
//            guard let sky = try context.fetch(request).first else {
//                throw Error.notFound
//            }
//            return sky
//        } catch {
//            throw Error.notFound
//        }
//    }
//}
