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
import MultiItem

struct PlanetEvents {
    let planet: Planet.Type
    let observer: CLLocation
    let timezone: TimeZone
    let rise: Date?
    let set: Date?
    var transit: Date? = nil
    let locations: [Location]
    
    var title: String { String(describing: planet) }
    var color: SwiftUI.Color { Color(planet.averageColor) }

}

extension PlanetEvents: CelestialEvents {
    var celestial: CelestialBody.Type { planet }

}

extension PlanetEvents: Identifiable, Equatable, Hashable {
    static func == (lhs: PlanetEvents, rhs: PlanetEvents) -> Bool {
        lhs.title == rhs.title
    }
    
    var id: String { title }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

extension PlanetEvents {
    
    struct Location: Identifiable {
        var id: Date {date}
        let date: Date
        let altitude: Double
        let azimuth: Double
        var aboveHorizon: Bool { altitude > 0 }
        var northBasedAzimuth: Double { return (Degree(azimuth) + 180).reduced.value }
    }
}

extension PlanetEvents: Item {
    
    var glyph: PlanetView {
        PlanetView(celestial: title)
    }
    
}

extension PlanetEvents: Labelable {
    var label: String { "Rises" }
    var sublabel: String? { rise?.time(timezone) }
}

extension PlanetEvents: Detailable {
    var detail: String { "Transits" }
    var subdetail: String? { transit?.time(timezone) }
    
    var info: String { "Sets" }
    var subinfo: String? { self.set?.time(timezone) }
}

extension PlanetEvents: Chartable {

    
    var points: [(Date, Double)] {
        locations.map{ ($0.date, $0.altitude) }
    }

}
