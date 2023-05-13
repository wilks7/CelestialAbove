//
//  Persistence.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import CoreData

struct SkyData {
    static let shared = SkyData()
    static var sharedStore: URL {
        FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.app.rifigy.CelestialAbove")!
            .appendingPathComponent("SkyData.sqlite")
    }
    let container: NSPersistentCloudKitContainer
    
    var context: NSManagedObjectContext { container.viewContext }

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "SkyData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            container.persistentStoreDescriptions.first!.url = Self.sharedStore
        }
        container.loadPersistentStores(completionHandler: handleError)
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    private func handleError(description: NSPersistentStoreDescription, error: Swift.Error?) -> Void {
        if let error = error as NSError? {
            /*
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    enum Error: Swift.Error {
        case load, save, add, delete
    }
}

extension Sky {
    static let request: NSFetchRequest<Sky> = NSFetchRequest<Sky>(entityName: "Sky")
    static let sorted: NSFetchRequest<Sky> = {
        let request = NSFetchRequest<Sky>(entityName: "Sky")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Sky.currentLocation, ascending: false)]
        return request
    }()
}
