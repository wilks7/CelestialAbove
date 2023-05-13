//
//  File.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import Foundation
import WeatherKit

extension SunEvents: Events {
    var name: String { "Sun" }
    var rise: Date? { sunrise }
    var set: Date? { sunset }
    var transit: Date? { solarNoon }
}

extension MoonEvents: Events {
    var name: String { "Moon" }
    var rise: Date? { moonrise }
    var set: Date? { moonset }
    var transit: Date? {nil}
    
}
