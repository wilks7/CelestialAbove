//
//  MockData+Celestial.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation
import SwiftAA
import CoreLocation

extension MockData {
    
    static let saturn: PlanetEvents = CelestialService().createEvent(for: Saturn.self, at: locationNY, in: timezoneNY)
    static let mars: PlanetEvents = CelestialService().createEvent(for: Mars.self, at: locationNY, in: timezoneNY)
    static let jupiter: PlanetEvents = CelestialService().createEvent(for: Jupiter.self, at: locationNY, in: timezoneNY)
    static let venus: PlanetEvents = CelestialService().createEvent(for: Venus.self, at: locationNY, in: timezoneNY)
    
    static var events: [PlanetEvents] { [saturn, mars, jupiter, venus] }
    
    static func simulateMars(for date: Date) -> [PlanetEvents.Location] {
        var locations: [PlanetEvents.Location] = []
        
        for hour in 0..<24 {
            let currentDate = Calendar.current.date(byAdding: .hour, value: hour, to: date)!
            
            // Assuming a linear change for simplicity
            let altitude: Double = (hour <= 12) ? Double(hour) * 15.0 : (24 - Double(hour)) * 15.0
            let azimuth: Double = 90.0 + Double(hour) * (180.0 / 12.0)
            
            let location = PlanetEvents.Location(
                date: currentDate,
                altitude: altitude,
                azimuth: azimuth
            )
            
            locations.append(location)
        }
        
        return locations
    }
}
