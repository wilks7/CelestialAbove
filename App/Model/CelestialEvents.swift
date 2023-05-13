//
//  CelestialEvents.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import SwiftAA

struct CelestialEvents: Events {
    let celestial: Planet.Type
    var name: String { String(describing: celestial) }
    var rise: Date?
    var set: Date?
    var transit: Date?
    var locations: [Location] = []
    var color: SwiftUI.Color { Color(celestial.averageColor) }
    
    struct Location: Codable {
        let date: Date
        let altitude: Double
        let azimuth: Double
        var aboveHorizon: Bool { altitude > 0 }
        var northBasedAzimuth: Double { return (Degree(azimuth) + 180).reduced.value }
    }
}

extension CelestialEvents: Identifiable {
    var id: String { name }
}

extension CelestialEvents.Location: Identifiable {
    var id: Date { date }
}
