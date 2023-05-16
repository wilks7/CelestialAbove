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

enum EventType: String { case rise, set, transit }
extension Events {
    var color: SwiftUI.Color { .white }
    
    var nextEvent: (date: Date?, type: EventType) {
        if let sunrise = rise, let sunset = set {
            let now = Date.now
            if now < sunrise {
                return (sunrise, .rise)
            } else if now < sunset {
                return (sunset, .set)
            } else {
                return (sunrise, .rise)
            }
        } else {
            return (nil, .transit)
        }
    }
    
    var nextTime: String? {
        nextEvent.date?.time()
    }
}
