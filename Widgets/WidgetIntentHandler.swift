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
        let skies:[Sky] = SkyData.allSkies()
        
        let skyIDs = skies.map { sky in
            SkyID(identifier: sky.id, display: sky.title ?? "Title")
        }
        
        print("[Intent Handler] Fetched \(skyIDs.count) skies")
        return INObjectCollection(items: skyIDs )

    }
    
    
    func defaultSky(for intent: StatusIntent) -> SkyID? {
        let skies:[Sky] = SkyData.allSkies()
        let id = intent.sky

        if let currentLocation = skies.first(where: {$0.currentLocation ?? false}) {
            return SkyID(identifier: currentLocation.id, display: "Current Location")
        } else if let first = skies.first(where: {$0.id == id?.identifier}) {
            return SkyID(identifier: first.id, display: first.title ?? "Title")
        } else {
            return nil
        }
    }
}

