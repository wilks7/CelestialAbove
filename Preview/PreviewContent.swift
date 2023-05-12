//
//  SkyData.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import CoreData
import SwiftUI


extension PreviewProvider {
    static var skyData: SkyData { SkyData.preview }
    static var NY: Sky {
        let results = try? skyData.context.fetch(Sky.request)
        return (results?.first!)!
    }
}

extension SkyData {
    static var preview: SkyData = {
        let result = SkyData(inMemory: true)
        let viewContext = result.container.viewContext
        let ny = Sky(context: viewContext, title: "New York", latitude: 40.7831, longitude: -73.9712, altitude: 10, timezoneID: "America/New_York")
        let la = Sky(context: viewContext, title: "Los Angeles", latitude: 34.0522, longitude: -118.2437, altitude: 10, timezoneID: "America/Los_Angeles")
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
