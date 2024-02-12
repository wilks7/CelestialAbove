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
class Sky: Identifiable, NightSky {
    
    var id: String { "\(latitude),\(longitude)" }
    var title: String = "New York"
    
    private var timezoneID: String = "America/New_York"
    private var altitude: Double = 100
    private var latitude: Double = 40.7831
    private var longitude: Double = -73.9712
    var currentLocation: Bool = false

    var weatherData: Data = Data()
    @Transient
    var events: [PlanetEvents] = []
    
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
    
    init(key sky: SkyKey) {
        self.title = sky.title
        self.timezoneID = sky.timezone.identifier
        self.latitude = sky.location.coordinate.latitude
        self.longitude = sky.location.coordinate.longitude
        self.altitude = sky.location.altitude
        self.currentLocation = sky.currentLocation
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
    
    
    var weather: Weather? {
        try? JSONDecoder().decode(Weather.self, from: weatherData)
    }
}

extension Sky {
    
    @MainActor
    func fetchData(service: WeatherService) async throws {
//        self.events = CelestialService.fetchPlanetEvents(at: location, in: timezone, title: title)
        
        let lastUpdated = weather?.currentWeather.date
        
        if shouldFetch(lastUpdated: lastUpdated) {
            let weather = try await service.weather(for: self)
            try withAnimation {
                self.weatherData = try JSONEncoder().encode(weather)
            }
        }
    }
    
    private func shouldFetch(lastUpdated: Date?) -> Bool {
        guard let lastUpdated else {return true}
        
        let timeInterval: Double = 86400
        let lastInterval = Date().timeIntervalSince(lastUpdated)
        
        return lastInterval > timeInterval

    }
}
