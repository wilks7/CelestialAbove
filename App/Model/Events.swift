//
//  Event.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import SwiftAA

protocol Events {
    var celestial: CelestialBody.Type {get}
    var title: String {get}
    var rise: Date? {get}
    var set: Date? {get}
    var transit: Date? {get}
}

enum EventType: String { case rise, set, transit }

func nextEvent(date now: Date = .now, rise: Date?, set: Date?, transit: Date?) -> (date: Date?, type: EventType) {
    if let rise, let set {
        if now < rise {
            return (rise, .rise)
        } else if now < set {
            return (set, .set)
        } else {
            return (rise, .rise)
        }
    } else {
        return (nil, .transit)
    }
}

//
//
//import CoreLocation
//extension Events {
//    var symbolName: String {"circle"}
//    
//    var label: String {
//        nextEvent.type.rawValue.capitalized
//    }
//    
//    var detail: String? {
//        nextTime
//    }
//    
//    func point(for date: Date, at location: CLLocation) -> Double {
//        CelestialService().celestialLocation(celestial:celestial, at: location, at: date).altitude
//    }
//}

