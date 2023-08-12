//
//  SkyData.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import WeatherKit
import CoreLocation

extension PreviewProvider {

    static var timezone: TimeZone { MockData.timezoneLA }
    static var forecast: [MockData.MockWeather] { MockData.makeForecast(for: .day) }
    static var event: CelestialEvents { MockData.mars }
    static var events: [CelestialEvents] { [MockData.saturn, MockData.mars, MockData.jupiter, MockData.venus] }
}
class MockData{
    static let locationNY: CLLocation = CLLocation(latitude: 40.7831, longitude: -73.9712)
    static var timezoneNY: TimeZone { TimeZone(identifier: "America/New_York")! }
    static var timezoneLA: TimeZone { TimeZone(identifier: "America/Los_Angeles")! }
    
}
//
