//
//  Sky.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/11/23.
//

import Foundation
import SwiftData
import CoreLocation
import WeatherKit
import SwiftUI

@Model
class Sky: Identifiable {
    
    public var id: String {
        "\(latitude),\(longitude)"
    }
    
    let title: String = "New York"
    private let timezoneID: String = "America/New_York"
    private let altitude: Double = 279
    private let latitude: Double = 40.7831
    private let longitude: Double = -73.9712
    
    var weatherData: Data? = nil
    let currentLocation: Bool = false
    
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
    
    
    @Transient
    var weather: Weather? {
        guard let weatherData else {return nil}
        return try? JSONDecoder().decode(Weather.self, from: weatherData)
    }
}

extension Sky {
    
    @MainActor
    func fetchData(service: WeatherService) async {
        if let weather {
            print("Decoded Weather for \(title)")
            if Date().timeIntervalSince(weather.currentWeather.date) > 86400 {
                let weather = try? await service.weather(for: self)
                print("Fetched Weather for \(title)")
                self.weatherData = try? JSONEncoder().encode(weather)
            }
        } else {
            let weather = try? await service.weather(for: self)
            print("Fetched Weather for \(title)")
            self.weatherData = try? JSONEncoder().encode(weather)
        }


    }

    
}
