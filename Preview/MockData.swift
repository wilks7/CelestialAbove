//
//  SkyData.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import WeatherKit
import CoreLocation

class MockData {
    
    private init() {}
    
    static let shared = MockData()
    
    static let locationNY: CLLocation = CLLocation(latitude: 40.7831, longitude: -73.9712)
    static var timezoneNY: TimeZone { TimeZone(identifier: "America/New_York")! }
    static var timezoneLA: TimeZone { TimeZone(identifier: "America/Los_Angeles")! }
    
    static var forecast: [MockData.MockWeather] { makeForecast(for: .day) }    
}
