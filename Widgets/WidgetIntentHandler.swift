//
//  WidgetIntentHandler.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import Intents
import CoreData

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension IntentHandler: StatusIntentHandling {
    func provideSkyOptionsCollection(for intent: StatusIntent) async throws -> INObjectCollection<SkyID> {
        let skies:[Sky] = SkyData.shared.skies()
        
        let skyIDs = skies.map { sky in
            SkyID(identifier: sky.id.uuidString, display: sky.title)
        }
        
        print("[Intent Handler] Fetched \(skyIDs.count) skies")
        return INObjectCollection(items: skyIDs )

    }
    
    
    func defaultSky(for intent: StatusIntent) -> SkyID? {
        let skies:[Sky] = SkyData.shared.skies()
        let id = intent.sky

        if let currentLocation = skies.first(where: {$0.currentLocation}) {
            return SkyID(identifier: currentLocation.id.uuidString, display: "Current Location")
        } else if let first = skies.first(where: {$0.id.uuidString == id?.identifier}) {
            return SkyID(identifier: first.id.uuidString, display: first.title)
        } else {
            return nil
        }
    }
}

