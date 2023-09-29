//
//  CelestialService.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation
import SwiftAA
import CoreLocation

/// A service class dedicated to celestial-related functionalities.
class CelestialService {
    
    /// Fetches celestial events for specific planets at the given location and timezone.
    /// - Parameters:
    ///   - location: The geographical location to fetch celestial events for.
    ///   - timezone: The timezone to use for date calculations.
    ///   - date: The date for which to fetch celestial events. Defaults to the current date.
    ///   - title: An optional title for the event.
    /// - Returns: An array of celestial events.
    func fetchPlanetEvents(at location: CLLocation, in timezone: TimeZone, at date: Date = .now, title: String? = nil) -> [CelestialEvents] {
        let planets: [Planet.Type] = [Mars.self, Saturn.self, Venus.self, Jupiter.self]
        var events: [CelestialEvents] = []
        for planet in planets {
            let event = createEvent(for: planet, at: location, in: timezone, date: date)
            events.append(event)
        }
        logger.notice("[\(title ?? location.id)] \(events.count) events")
        return events
    }
    
    /// Calculates the celestial location for a specific celestial on a given date and location.
    /// - Parameters:
    ///   - celestial: The celestial body to determine the location for.
    ///   - location: The geographical location.
    ///   - date: The date of interest.
    /// - Returns: The celestial location of the planet.
    func celestialLocation(celestial: CelestialBody.Type, at location: CLLocation, at date: Date) -> CelestialEvents.Location {
        return calculateCelestialLocation(for: celestial, at: location, at: date)
    }
    
    /// Calculates the celestial location for a specific planet on a given date and location.
    /// - Parameters:
    ///   - planet: The celestial body to determine the location for.
    ///   - location: The geographical location.
    ///   - date: The date of interest.
    /// - Returns: The celestial location of the planet.
    func celestialLocation(for planet: Planet.Type, at location: CLLocation, at date: Date) -> CelestialEvents.Location {
        return calculateCelestialLocation(for: planet, at: location, at: date)
    }
    
    /// Calculates the celestial location based on provided parameters.
    /// - Parameter parameter: Parameters that define the celestial body, location, and date.
    /// - Returns: The celestial location.
    func celestialLocation(_ parameter: Parameter) -> CelestialEvents.Location {
        return calculateCelestialLocation(for: parameter.celestial, at: parameter.location, at: parameter.date)
    }
    
    private func calculateCelestialLocation(for celestial: CelestialBody.Type, at location: CLLocation, at date: Date) -> CelestialEvents.Location {
        let object = celestial.init(julianDay: .init(date), highPrecision: true)
        let geographic = GeographicCoordinates(location)
        let horizontalCoord = object.makeHorizontalCoordinates(with: geographic)
        
        return CelestialEvents.Location(date: date, altitude: horizontalCoord.altitude.value, azimuth: horizontalCoord.azimuth.value)
    }
    
    /// Creates a celestial event for a specific planet.
    /// - Parameters:
    ///   - planet: The celestial body to create an event for.
    ///   - location: The geographical location.
    ///   - timezone: The timezone for date calculations.
    ///   - date: The date of interest. Defaults to the current date.
    /// - Returns: A celestial event.
    func createEvent(for planet: Planet.Type, at location: CLLocation, in timezone: TimeZone, date: Date = .now) -> CelestialEvents {
        let locations = fetchLocations(for: planet, at: location, in: timezone)
        let object = planet.init(julianDay: .init(date), highPrecision: true)
        let riseTransitSet = object.riseTransitSetTimes(for: GeographicCoordinates(location))
        
        var setTime = riseTransitSet.setTime?.date
        let riseTime = riseTransitSet.riseTime?.date
        let transitTime = riseTransitSet.transitTime?.date
        
//        if let riseTime = riseTime, let _setTime = setTime {
//            if _setTime < riseTime {
//                setTime = Calendar.current.date(byAdding: .day, value: 1, to: _setTime)
//            }
//        }
        
        return CelestialEvents(
            planet: planet,
            location: location,
            timezone: timezone,
            rise: riseTime,
            set: setTime,
            transit: transitTime,
            locations: locations
        )
    }
    
    /// Fetches the celestial locations for a specific planet throughout a day.
    /// - Parameters:
    ///   - planet: The celestial body to fetch locations for.
    ///   - location: The geographical location.
    ///   - timezone: The timezone for date calculations.
    /// - Returns: An array of celestial locations over a 24-hour period.
    func fetchLocations(for planet: Planet.Type, at location: CLLocation, in timezone: TimeZone) -> [CelestialEvents.Location] {
        let start = Date.now.startOfDay(timezone)
        return (0...24).compactMap { hour -> CelestialEvents.Location? in
            guard let date = Calendar.current.date(byAdding: .hour, value: hour, to: start) else {
                return nil
            }
            return self.celestialLocation(for: planet, at: location, at: date)
        }
    }
    
    /// Fetches the celestial locations for a specific planet throughout a day.
    /// - Parameters:
    ///   - planet: The celestial body to fetch locations for.
    ///   - location: The geographical location.
    ///   - timezone: The timezone for date calculations.
    /// - Returns: An array of celestial locations over a 24-hour period.
    func fetchLocations(celestial: CelestialBody.Type, at location: CLLocation, in timezone: TimeZone) -> [CelestialEvents.Location] {
        let start = Date.now.startOfDay(timezone)
        return (0...24).compactMap { hour -> CelestialEvents.Location? in
            guard let date = Calendar.current.date(byAdding: .hour, value: hour, to: start) else {
                return nil
            }
            return self.celestialLocation(celestial: celestial, at: location, at: date)
        }
    }
    
    func fetchLocations(
        celestial: CelestialBody.Type,
        at location: CLLocation,
        within dateRange: ClosedRange<Date> = Date.now.startOfDay()...Date.now.endOfDay(),
        by component: Calendar.Component = .hour) -> [CelestialEvents.Location] {
        
        // Extract the start date from the range
        let startDate = dateRange.lowerBound
        
        // Calculate the number of components between the start and end dates
        let difference = Calendar.current.dateComponents([component], from: startDate, to: dateRange.upperBound)
        guard let stepCount = difference.value(for: component) else {
            return []
        }

        // Generate celestial locations for each step within the range
        return (0...stepCount).compactMap { step -> CelestialEvents.Location? in
            guard let date = Calendar.current.date(byAdding: component, value: step, to: startDate) else {
                return nil
            }
            return self.celestialLocation(celestial: celestial, at: location, at: date)
        }
    }

}

/// A helper structure to package multiple parameters for celestial calculations.
extension CelestialService {
    struct Parameter {
        /// The celestial body of interest.
        let celestial: CelestialBody.Type
        /// The geographical location.
        let location: CLLocation
        /// The date of interest. Defaults to the current date.
        var date: Date = .now
    }
}

/// Provides a debugging representation for `CelestialService`.
extension CelestialService: DebugLog {
    static let emoji = "🪐"
}
