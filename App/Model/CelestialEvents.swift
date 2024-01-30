//
//  Event.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import SwiftAA
import WeatherKit

enum EventType: String { case rise, set, transit }

protocol CelestialEvents {
    var celestial: CelestialBody.Type {get}
    var title: String {get}
    var rise: Date? {get}
    var set: Date? {get}
    var transit: Date? {get}
}

extension CelestialEvents {
    
    func isVisible(with sun: SunEvents?) -> Bool {
        guard let sunrise = sun?.sunrise, let sunset = sun?.sunset else {return false}
        
        if let rise, let set {
            return (rise > sunset) || (set < sunrise)
        } else { return false }
    }
}



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

extension MoonEvents: CelestialEvents {
    var celestial: CelestialBody.Type { Moon.self }
    var title: String { "Moon" }
    var rise: Date? { moonrise }
    var set: Date? { moonset }
    var transit: Date? {nil}
    
    var glyph: some View {
        PlanetView(celestial: title)
    }
}

extension SunEvents: CelestialEvents {
    var celestial: CelestialBody.Type { Sun.self }
    var title: String { "Sun" }
    var rise: Date? { sunrise }
    var set: Date? { sunset }
    var transit: Date? { solarNoon }
    
    var glyph: some View {
        PlanetView(celestial: title)
    }

}
