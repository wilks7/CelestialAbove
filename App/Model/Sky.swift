//
//  Sky.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import CoreData
import CoreLocation
import SwiftUI
import WeatherKit

public class Sky: NSManagedObject {
    
    public var timezone: TimeZone { TimeZone(identifier: timezoneID) ?? Calendar.current.timeZone }
    public var location: CLLocation { CLLocation(latitude: latitude, longitude: longitude) }
    
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var currentLocation: Bool
    @NSManaged private var timezoneID: String
    @NSManaged private var altitude: Double
    @NSManaged private var latitude: Double
    @NSManaged private var longitude: Double
    @NSManaged private var weatherData: Data?

    @Published private(set) var weather: Weather? {
        willSet { objectWillChange.send() }
    }
    
    @Published private(set) var events: [CelestialEvents] = [] {
        willSet { objectWillChange.send() }
    }
    
    @Published var color: Color = .random() {
        willSet { objectWillChange.send() }
    }
}

// MARK: - Weather
extension Sky {
    
    func fetchData(){
        if self.events.isEmpty {
            self.events = CelestialService().fetchPlanetEvenets(at: location, in: timezone, title: title)
        }
        guard self.weather == nil else {return}
        guard let weatherData, let weather = try? JSONDecoder().decode(Weather.self, from: weatherData) else {
            fetchForecast()
            return
        }

        if Calendar.current.isDateInToday(weather.currentWeather.date) {
            print("💿 [\(title)] has weather")
            self.weather = weather
        } else {
            fetchForecast(weather)
        }
    }
    
    private func fetchForecast(_ weather: Weather? = nil){
        Task { @MainActor in
            let weather = try await WeatherService.shared.fetchWeather(for: location, title: title, stored: weather)
            let weatherData = try JSONEncoder().encode(weather)
            self.weatherData = weatherData
            self.weather = weather

            do {
                if let managedObjectContext {
                    try managedObjectContext.save()
                }
            } catch {
                print(error)
            }
            
        }
    }
    
}

// MARK: CoreData Init
extension Sky {
    
    public override func awakeFromFetch() {
        super.awakeFromFetch()
    }

    
    public convenience init(context: NSManagedObjectContext, title: String, timezone: TimeZone, location: CLLocation, weatherData: Data? = nil, currentLocation: Bool = false) {
        self.init(context: context)
        self.id = UUID()
        self.currentLocation = currentLocation
        self.timezoneID = timezone.identifier
        self.title = title
        self.altitude = location.altitude
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.weatherData = weatherData
    }
    
}

extension Sky: Identifiable {}

