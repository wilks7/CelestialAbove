//
//  MoonEvents+MockData.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/26/23.
//

import Foundation
import WeatherKit

extension MockData {
    static var moonEvents: MoonEvents {
        let date = Date.now
        let startOfDay = date.startOfDay()
        
        // Mock times for moon events. Adjust as needed.
        let moonriseTime = Calendar.current.date(byAdding: .hour, value: 20, to: startOfDay)!
        let moonsetTime = Calendar.current.date(byAdding: .hour, value: 6, to: startOfDay)!
        
        // Selecting a random MoonPhase rawValue
        let randomPhaseRawValue = MoonPhase.allCases.randomElement()?.rawValue ?? MoonPhase.new.rawValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"  // ISO8601 format
        
        let dict: [String: Any] = [
            "phase": randomPhaseRawValue,
            "moonrise": dateFormatter.string(from: moonriseTime),
            "moonset": dateFormatter.string(from: moonsetTime)
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: [])
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let mockMoonEvents = try! decoder.decode(MoonEvents.self, from: jsonData)
        return mockMoonEvents
    }

}
