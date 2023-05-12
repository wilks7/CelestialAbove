//
//  WeatherService.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import CoreLocation
import WeatherKit

extension WeatherService {
    
    func fetchWeather(for location: CLLocation, title: String? = nil, stored: Weather? = nil) async throws -> Weather {
        let status = check(weather: stored)
        let name = title ?? location.id
        
        guard status != .valid else {
            print("\(name) has weather for \(Date.now.formatted(date: .numeric, time: .omitted))")
            throw Error.valid
        }
        do {
            let result = try await weather(for: location)
            print("Fetched \(name)")
            return result
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    private func check(weather: Weather?) -> WeatherStatus {
        if let weather {
            let fetchedDay = weather.currentWeather.date
            if Calendar.current.isDateInToday(fetchedDay) {
                return .valid
            } else {
                return .old
            }
        } else {
            return .none
        }
    }
    
    enum WeatherStatus {
        case none, old, valid
    }
    
    enum Error: Swift.Error {
        case valid
    }
    
}

extension WeatherService: DebugPrint {
    static let emoji = "☁️"
}
