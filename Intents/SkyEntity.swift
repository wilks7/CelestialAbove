//
//  SkyEntity.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/6/23.
//

import Foundation
import AppIntents
import CoreLocation

struct SkyEntity: AppEntity {
    var id: String { location.id }
    let title: String
    let location: CLLocation
    let timezone: TimeZone
    let weatherData: Data?
    

    static var defaultQuery = SkyQuery()
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Night Sky"
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)")
    }
}
struct SkyQuery: EntityQuery {
    func entities(for identifiers: [SkyEntity.ID]) async throws -> [SkyEntity] {
        SkyData.shared.skies(for: identifiers).map{
            SkyEntity(title: $0.title, location: $0.location, timezone: $0.timezone, weatherData: $0.weatherData)
        }
    }
    func suggestedEntities() async throws -> [SkyEntity] {
        SkyData.shared.allSkies().map{
            SkyEntity(title: $0.title, location: $0.location, timezone: $0.timezone, weatherData: $0.weatherData)
        }
    }
    
    func defaultResult() async -> SkyEntity? {
        guard let first = SkyData.shared.allSkies().first
        else {return SkyEntity.NewYork}
        return SkyEntity(title: first.title, location: first.location, timezone: first.timezone, weatherData: first.weatherData)

    }
}


extension SkyEntity {
    static let NewYork = SkyEntity(title: "New York", location: CLLocation(latitude: 40.7831, longitude: -73.9712), timezone: TimeZone(identifier: "America/New_York")!, weatherData: nil)
}
