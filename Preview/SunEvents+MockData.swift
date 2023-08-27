//
//  SunEvents+MockData.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/26/23.
//

import Foundation
import WeatherKit

extension MockData {
    static var sunEvents: SunEvents {

        let startOfDay = Date.now.startOfDay()

        let mockSunEventsData: [String: Date?] = [
            "astronomicalDawn": startOfDay.adding(hours: 4),
            "nauticalDawn": startOfDay.adding(hours: 4, minutes: 30),
            "civilDawn": startOfDay.adding(hours: 5),
            "sunrise": startOfDay.adding(hours: 5, minutes: 30),
            "solarNoon": startOfDay.adding(hours: 12),
            "sunset": startOfDay.adding(hours: 18, minutes: 30),
            "civilDusk": startOfDay.adding(hours: 19),
            "nauticalDusk": startOfDay.adding(hours: 19, minutes: 30),
            "astronomicalDusk": startOfDay.adding(hours: 20),
            "solarMidnight": startOfDay.adding(hours: 23, minutes: 30)
        ]

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let jsonData = try! encoder.encode(mockSunEventsData)
        let jsonString = String(data: jsonData, encoding: .utf8)!

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let sunEventsMock = try! decoder.decode(SunEvents.self, from: jsonString.data(using: .utf8)!)
        return sunEventsMock
     
    }
}


fileprivate extension Date {
    func adding(hours: Int, minutes: Int = 0) -> Date {
        return self.addingTimeInterval(TimeInterval(hours * 3600 + minutes * 60))
    }
}
