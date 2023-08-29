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
            print("[\(name)] has weather for \(Date.now.formatted(date: .numeric, time: .omitted))")
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
    
    private func print(weather: Weather?) {
        guard let weather else {return}
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted  // To get a nicely formatted JSON string
        if let jsonData = try? encoder.encode(weather) {
            
            // Convert JSON data to a JSON string
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("\n\n\n")
                print(jsonString)
                print("\n\n\n")

            } else {
                print("Error: Couldn't convert JSON data to a string.")
            }
            
        } else {
            print("Error: Couldn't convert HourWeather to JSON data.")
        }
    }
    
}

extension WeatherService: DebugPrint {
    static let emoji = "☁️"
}
