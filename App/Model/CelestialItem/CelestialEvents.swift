//
//  CelestialEvents.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import SwiftAA
import WeatherKit
import CoreLocation

struct CelestialEvents: Events {
    
    let planet: Planet.Type
    let location: CLLocation
    let rise: Date?
    let set: Date?
    var transit: Date? = nil
    let locations: [Location]
    
    var title: String { String(describing: planet) }
    var color: SwiftUI.Color { Color(planet.averageColor) }
    var celestial: CelestialBody.Type { planet }

}

extension CelestialEvents: Identifiable, Equatable, Hashable {
    static func == (lhs: CelestialEvents, rhs: CelestialEvents) -> Bool {
        lhs.title == rhs.title
    }
    
    var id: String { title }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension CelestialEvents {
    
    struct Location: ItemChartData {
        let date: Date
        let altitude: Double
        let azimuth: Double
        var aboveHorizon: Bool { altitude > 0 }
        var northBasedAzimuth: Double { return (Degree(azimuth) + 180).reduced.value }
        
        var reference: Date { date }
        var value: Double { altitude }
    }
}


