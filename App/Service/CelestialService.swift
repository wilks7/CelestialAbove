//
//  CelestialService.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation
import SwiftAA
import CoreLocation

class CelestialService {
    
    func fetchPlanetEvenets(at location: CLLocation, in timezone: TimeZone, at date: Date = .now, title: String? = nil) -> [CelestialEvents] {
        let planets: [Planet.Type] = [Mars.self, Saturn.self, Venus.self, Jupiter.self]
        var events: [CelestialEvents] = []
        for planet in planets {
            let event = fetchEvent(for: planet, at: location, in: timezone, at: date)
            events.append(event)
        }
        print("[\(title ?? location.id)] \(events.count) events")
        return events
    }

    func fetchEvent(for planet: Planet.Type, at location: CLLocation, in timezone: TimeZone, at date: Date = .now) -> CelestialEvents {
        var event = createEvent(for: planet, at: location, date: date)
        event.locations = fetchLocations(for: planet, at: location, in: timezone)
        return event
    }
    
    func celestialLocation(for planet: Planet.Type, at location: CLLocation, at date: Date) -> CelestialEvents.Location {
        let object = planet.init(julianDay: .init(date), highPrecision: true)
        let geographic = GeographicCoordinates(location)
        let horizontalCoord = object.makeHorizontalCoordinates(with: geographic)
        
        return CelestialEvents.Location(date: date, altitude: horizontalCoord.altitude.value, azimuth: horizontalCoord.azimuth.value)
    }
    
    private func createEvent(for planet: Planet.Type, at location: CLLocation, date: Date = .now) -> CelestialEvents {
        
        let object = planet.init(julianDay: .init(date), highPrecision: true)
        let riseTransitSet = object.riseTransitSetTimes(for: GeographicCoordinates(location))
        
        var setTime = riseTransitSet.setTime?.date
        let riseTime = riseTransitSet.riseTime?.date
        let transitTime = riseTransitSet.transitTime?.date
        
        if let riseTime, let _setTime = setTime {
            if _setTime < riseTime {
                setTime = Calendar.current.date(byAdding: .day, value: 1, to: _setTime)
            }
        }
        
        return CelestialEvents(
            celestial: planet,
            rise: riseTime,
            set: setTime,
            transit: transitTime
        )
    }
    
    private func fetchLocations(for planet: Planet.Type, at location: CLLocation, in timezone: TimeZone) -> [CelestialEvents.Location] {
        var locations: [CelestialEvents.Location] = []
        let start = Date.now.startOfDay(timezone)
        
        for h in 1..<24 {
            let date = Calendar.current.date(byAdding: .hour, value: h, to: start)!
            let celestialLocation = celestialLocation(for: planet, at: location, at: date)
            locations.append(celestialLocation)
        }
        return locations

    }

}

extension CelestialService: DebugPrint {
    static let emoji = "🪐"
}
