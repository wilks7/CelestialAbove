//
//  Event.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI

protocol Events {
    var name: String {get}
    var rise: Date? {get}
    var set: Date? {get}
    var transit: Date? {get}
    var color: Color {get}
}

enum EventType: String { case rise, set, transit }
extension Events {
    var color: Color { .white }
    
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
    
    var nextTime: String {
        nextEvent.date?.time() ?? "--"
    }
}


