//
//  File.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import Foundation
import WeatherKit
import SwiftAA

extension SunEvents: Events {
    var celestial: CelestialBody.Type { Sun.self }
    var title: String { "Sun" }
    var rise: Date? { sunrise }
    var set: Date? { sunset }
    var transit: Date? { solarNoon }
}

extension MoonEvents: Events {
    var celestial: CelestialBody.Type { Moon.self }
    var title: String { "Moon" }
    var rise: Date? { moonrise }
    var set: Date? { moonset }
    var transit: Date? {nil}

}
