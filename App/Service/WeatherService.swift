//
//  WeatherService.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import CoreLocation
import WeatherKit

extension WeatherService {

     func fetchWeather(for sky: Sky) async throws -> Weather {
        let defaults = UserDefaults.standard
        let service = WeatherService()

        if let data = defaults.data(forKey: sky.id),
           let weather = try? JSONDecoder().decode(Weather.self, from: data),
           Date().timeIntervalSince(weather.currentWeather.date) < 86400 { // 86400 seconds = 1 day
            print("💿 [Cache] Fetched \(sky.title) - \(weather.currentWeather.date.formatted(date: .abbreviated, time: .shortened)) - \(weather.daily.count) Daily")
            return weather
        } else {
            let weather = try await service.fetchWeather(for: sky.location, title: sky.title)
            if let encoded = try? JSONEncoder().encode(weather) {
                defaults.set(encoded, forKey: sky.id)
            }
            return weather
        }
    }
    
    func fetchWeather(for location: CLLocation, title: String? = nil, stored: Weather? = nil) async throws -> Weather {
//        let status = check(weather: stored)
        let name = title ?? location.id
        
//        guard status != .valid else {
//            print("[\(name)] has weather for \(Date.now.formatted(date: .numeric, time: .omitted))")
//            throw Error.valid
//        }
        do {
            let result = try await weather(for: location)
            print("Fetched \(name)")
            return result
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    

    func setWeather(_ weather: Weather, forKey key: String) {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(weather) {
            defaults.set(encoded, forKey: key)
        }
    }

//    
//    func weather(forKey key: String) -> Weather? {
//        let defaults = UserDefaults.standard
//
//        if let data = defaults.data(forKey: key),
//           let decodedWeather = try? JSONDecoder().decode(Weather.self, from: data),
//           Date().timeIntervalSince(decodedWeather.date) < 86400 { // 86400 seconds = 1 day
//            return decodedWeather
//        }
//        return nil
//    }
    
    
//    private func check(weather: Weather?) -> WeatherStatus {
//        if let weather {
//            let fetchedDay = weather.currentWeather.date
//            if Calendar.current.isDateInToday(fetchedDay) {
//                return .valid
//            } else {
//                return .old
//            }
//        } else {
//            return .none
//        }
//    }
    
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
