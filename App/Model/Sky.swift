//
//  Sky.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/11/23.
//

import Foundation
import Observation
import SwiftData
import CoreLocation
import WeatherKit
import SwiftUI


@Model
class Sky: Identifiable {
//    let nightSky: NightSky = NightSky.NewYork
    
    var id: String { "\(latitude),\(longitude)" }
    let title: String = "New York"
    
    private let timezoneID: String = "America/New_York"
    private let altitude: Double = 100
    private let latitude: Double = 40.7831
    private let longitude: Double = -73.9712
    var currentLocation: Bool = false

    var weatherData: Data? = nil
    
    init(title: String,
         timezone: TimeZone,
         location: CLLocation,
         current: Bool = false) {
        
        self.title = title
        self.timezoneID = timezone.identifier
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.altitude = location.altitude
        self.currentLocation = current
    }

}

extension Sky {
    
    @Transient
    public var timezone: TimeZone {
        TimeZone(identifier: timezoneID) ?? Calendar.current.timeZone
    }
    
    @Transient
    public var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
//    @Transient
    var weather: Weather? {
        guard let weatherData else {return nil}
        return try? JSONDecoder().decode(Weather.self, from: weatherData)
    }
}

extension Sky {
    
    @MainActor
    func fetchData(service: WeatherService) async throws {
        
        let lastUpdated = weather?.currentWeather.date
        
        guard let lastUpdated, Date().timeIntervalSince(lastUpdated) > 86400
            else {return}
        
        let weather = try await service.weather(for: self)
        self.weatherData = try JSONEncoder().encode(weather)
    }

    
}
