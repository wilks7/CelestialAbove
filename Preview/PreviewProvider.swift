//
//  SkyData.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import CoreData
import SwiftUI
import WeatherKit

extension PreviewProvider {
    static var skyData: SkyData { SkyData.preview }

    static var skies: [Sky] {
        let results = try? skyData.context.fetch(Sky.sorted)
        return results ?? []
    }
    static var sky: Sky {
        let results = try? skyData.context.fetch(Sky.sorted)
        return (results?.first!)!
    }
    
    static var timezone: TimeZone { MockData.timezoneLA }
    static var forecast: [MockData.MockWeather] { MockData.makeForecast(for: .day) }
    static var event: CelestialEvents { MockData.mars }
    static var events: [CelestialEvents] { [MockData.saturn, MockData.mars, MockData.jupiter, MockData.venus] }
}
class MockData{}
