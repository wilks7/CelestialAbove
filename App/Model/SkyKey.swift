//
//  SkyKey.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 2/11/24.
//

import Foundation
import CoreLocation

protocol NightSky: Identifiable {
    var title: String {get}
    var location: CLLocation {get}
    var timezone: TimeZone {get}
    var currentLocation: Bool {get}
    
}

struct SkyKey: Identifiable, Codable, NightSky {
    var id: String { "\(latitude),\(longitude)" }
    
    private let latitude: Double
    private let longitude: Double
    private let timezoneID: String
    
    let title: String
    let weatherData: Data?
    var currentLocation: Bool
    
    init(title: String, location: CLLocation, timezone: TimeZone, currenLocation: Bool = false, weatherData: Data? = nil) {
        self.timezoneID = timezone.identifier
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.title = title
        self.weatherData = weatherData
        self.currentLocation = currenLocation
    }
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    var timezone: TimeZone {
        TimeZone(identifier: timezoneID)!
    }
}
