//
//  Event.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import WeatherKit

enum EventType { case rise, set, transit }
protocol Events {
    var name: String {get}
    var rise: Date? {get}
    var set: Date? {get}
    var transit: Date? {get}
    var color: Color {get}
}
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

extension SunEvents: Events {
    var name: String { "Sun" }
    var rise: Date? { sunrise }
    var set: Date? { sunset }
    var transit: Date? { solarNoon }
}

extension MoonEvents: Events {
    var name: String { "Moon" }
    var rise: Date? { moonrise }
    var set: Date? { moonset }
    var transit: Date? {nil}
    
}
