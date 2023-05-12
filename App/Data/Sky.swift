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

public class Sky: NSManagedObject, Identifiable {
    
    @Published var color: Color? { // @Published is optional
        willSet {
            objectWillChange.send()
        }
    }
    @Published private(set) var nextEvent: String?

    @Published private(set) var weather: Weather? {
        didSet {
            guard let weather else { return }
            weatherData = try? JSONEncoder().encode(weather)
            try? self.managedObjectContext?.save()
        }
        willSet {
            objectWillChange.send()
        }
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var currentLocation: Bool
    @NSManaged private var timezoneID: String
    @NSManaged public var title: String
    @NSManaged public var altitude: Double
    @NSManaged private var latitude: Double
    @NSManaged private var longitude: Double
    @NSManaged private var weatherData: Data?

    public var timezone: TimeZone { TimeZone(identifier: timezoneID)! }
    public var location: CLLocation { CLLocation(latitude: latitude, longitude: longitude) }
    
    public convenience init(context: NSManagedObjectContext, title: String, latitude: Double, longitude: Double, altitude: Double, timezoneID: String, currentLocation: Bool = false) {
        self.init(context: context)
        self.id = UUID()
        self.currentLocation = currentLocation
        self.timezoneID = timezoneID
        self.title = title
        self.altitude = altitude
        self.latitude = latitude
        self.longitude = longitude
        self.weatherData = nil
    }
    
    public convenience init(context: NSManagedObjectContext, title: String, timezone: TimeZone, location: CLLocation, currentLocation: Bool = false) {
        self.init(context: context)
        self.id = UUID()
        self.currentLocation = currentLocation
        self.timezoneID = timezone.identifier
        self.title = title
        self.altitude = location.altitude
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.weatherData = nil
    }
    
    public override func awakeFromFetch() {
        super.awakeFromFetch()
        guard let data = weatherData else {return}
        do {
            let weather = try JSONDecoder().decode(Weather.self, from: data)
            if Calendar.current.isDateInToday(weather.currentWeather.date) {
                self.weather = weather
            } else {
                #warning("remove old data")
            }
        } catch {
            print(error)
        }
    }
}

extension Sky {
    
    @MainActor
    func fetchForecast() async {
        if let weather = try? await WeatherService.shared.fetchWeather(for: location, title: title, stored: weather) {
            self.weather = weather
        }
    }
        
    @MainActor
    func set(color: Color) {
        print("Setting Color: \(color.description)")
        self.color = color
    }
}

