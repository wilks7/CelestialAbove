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
    var color: SwiftUI.Color {get}
}




extension Events {
    var color: SwiftUI.Color { .white }
    
    var nextEvent: (date: Date?, type: EventType) {
        EventService().nextEvent(for: self, sunrise: rise, sunset: set)
    }

    var nextTime: String? {
        nextEvent.date?.time()
    }
    
}

import CoreLocation
extension Events {
    var symbolName: String {"circle"}
    
    var label: String {
        nextEvent.type.rawValue.capitalized
    }
    
    var detail: String? {
        nextTime
    }
    
    func point(for date: Date, at location: CLLocation) -> Double {
        CelestialService().celestialLocation(celestial:celestial, at: location, at: date).altitude
    }
}

