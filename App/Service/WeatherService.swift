//
//  WeatherService.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import CoreLocation
import WeatherKit


extension WeatherService {
    
    static var shared: WeatherService { .init() }
    
    func weather(for sky: Sky) async throws -> Weather {
        do {
            let weather = try await weather(for: sky.location)
            logger.notice("Fetched \(sky.title) \(weather.daily.count) Daily and \(weather.hourly.count) Hourly")
            return weather
        } catch {
            logger.error("Error Fetching \(sky.title)")
            throw error
        }
    }
}

extension WeatherService: DebugLog {
    static let emoji = "☁️"
}
