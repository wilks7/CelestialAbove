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

struct CelestialEvents: SkyItem, Events {
    
    var celestial: SwiftAA.CelestialBody.Type {
        planet
    }
    
    let planet: Planet.Type
    let location: CLLocation
    var title: String { String(describing: planet) }
    let rise: Date?
    let set: Date?
    var transit: Date? = nil
    let data: [Location]
    var color: SwiftUI.Color { Color(planet.averageColor) }
    
    struct Location {
        let date: Date
        let altitude: Double
        let azimuth: Double
        var aboveHorizon: Bool { altitude > 0 }
        var northBasedAzimuth: Double { return (Degree(azimuth) + 180).reduced.value }
    }
    
    static func data(for object: CelestialService.Parameter) -> Location {
        CelestialService().celestialLocation(object)
    }
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

extension CelestialEvents.Location: Identifiable, ChartData {
    var id: Date { date }
    var value: Double { altitude }
}
