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
    let timezone: TimeZone
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
    
    struct Location: Identifiable {
        var id: Date {date}
        let date: Date
        let altitude: Double
        let azimuth: Double
        var aboveHorizon: Bool { altitude > 0 }
        var northBasedAzimuth: Double { return (Degree(azimuth) + 180).reduced.value }

    }
}


extension SunEvents: Events, SkyItem {
    var celestial: CelestialBody.Type { Sun.self }
    var title: String { "Sun" }
    var rise: Date? { sunrise }
    var set: Date? { sunset }
    var transit: Date? { solarNoon }
    
    var glyph: some View {
        PlanetView(celestial: title)
    }
    
    var compact: some View {
        VStack(alignment: .leading, spacing: 0) {
            glyph
                .frame(width: 30, height: 30)
            Text(nextTime ?? "--")
        }
    }
    
    var chart: some View {
        let points = data()
        return ItemChart(chartPoints: points, showZero: true)
    }
    
    func data(for range: ClosedRange<Date> = Date.now.startOfDay()...Date.now.endOfDay(), component: Calendar.Component = .hour) -> [(Date,Double)] {
        []
    }
}

extension MoonEvents: Events, SkyItem {
    var celestial: CelestialBody.Type { Moon.self }
    var title: String { "Moon" }
    var rise: Date? { moonrise }
    var set: Date? { moonset }
    var transit: Date? {nil}
    
    var glyph: some View {
        PlanetView(celestial: title)
    }
    
    var compact: some View {
        VStack(alignment: .leading, spacing: 0) {
            glyph
                .frame(width: 30, height: 30)
            Text(nextTime ?? "--")
        }
    }
    
    var chart: some View {
        let points = data()
        return ItemChart(chartPoints: points, showZero: true)
    }
    
    func data(for range: ClosedRange<Date> = Date.now.startOfDay()...Date.now.endOfDay(), component: Calendar.Component = .hour) -> [(Date,Double)] {
        []
    }

}
