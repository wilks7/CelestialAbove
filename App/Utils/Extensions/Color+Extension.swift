//
//  Color+Extension.swift
//  CelestialAbove
//
//  Created by Michael on 5/12/23.
//

import SwiftUI

extension Color {
    static func random()-> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }

}

import WeatherKit
extension Color {
    static func colors(for sunEvents: SunEvents?, timezone: TimeZone = Calendar.current.timeZone, at time: Date = .now) -> [Color] {
        var astronomicalDawn: Double { sunEvents?.astronomicalDawn?.percent(timezone) ?? 0 }
        var nauticalDawn: Double { sunEvents?.nauticalDawn?.percent(timezone) ?? 0.25 }
        var civilDawn: Double { sunEvents?.civilDawn?.percent(timezone) ?? 0.33 }
        var sunrise: Double { sunEvents?.sunrise?.percent(timezone) ?? 0.48 }
        var solarNoon: Double { sunEvents?.solarNoon?.percent(timezone) ?? 0.59 }
        var sunset: Double { sunEvents?.sunset?.percent(timezone) ?? 0.65 }
        var civilDusk: Double { sunEvents?.civilDusk?.percent(timezone) ?? 0.78 }
        var nauticalDusk: Double { sunEvents?.nauticalDusk?.percent(timezone) ?? 0.85 }
        var astronomicalDusk: Double { sunEvents?.astronomicalDusk?.percent(timezone) ?? 0.95 }
        var solarMidnight: Double { sunEvents?.astronomicalDusk?.percent(timezone) ?? 1 }
        
        var backgroundTopStops: [Gradient.Stop] { [
            .init(color: .midnightStart, location: 0),
            .init(color: .midnightStart, location: astronomicalDawn),
            .init(color: .sunriseStart, location: nauticalDawn),
            .init(color: .sunriseStart, location: civilDawn),
            .init(color: .sunriseStart, location: sunrise),
            .init(color: .sunnyDayStart, location: solarNoon),
            .init(color: .sunsetStart, location: sunset),
            .init(color: .sunsetStart, location: civilDusk),
            .init(color: .sunsetStart, location: nauticalDusk),
            .init(color: .midnightStart, location: astronomicalDusk),
            .init(color: .midnightStart, location: solarMidnight),
            .init(color: .midnightStart, location: 1)

        ] }

        var backgroundBottomStops: [Gradient.Stop] { [
            .init(color: .midnightEnd, location: 0),
            .init(color: .midnightEnd, location: astronomicalDawn),
            .init(color: .sunriseEnd, location: nauticalDawn),
            .init(color: .sunriseEnd, location: civilDawn),
            .init(color: .sunriseEnd, location: sunrise),
            .init(color: .sunnyDayEnd, location: solarNoon),
            .init(color: .sunsetEnd, location: sunset),
            .init(color: .sunsetEnd, location: civilDusk),
            .init(color: .sunsetEnd, location: nauticalDusk),
            .init(color: .midnightEnd, location: astronomicalDusk),
            .init(color: .midnightEnd, location: solarMidnight),
            .init(color: .midnightEnd, location: 1)
        ] }
        
        let colorValue = time.percent(timezone)
        return [
            backgroundTopStops.interpolated(amount: colorValue),
            backgroundBottomStops.interpolated(amount: colorValue)
        ]
        
    }
}

extension Color {
    static let midnightStart = Color(hue: 0.66, saturation: 0.8, brightness: 0.1)
    static let midnightEnd = Color(hue: 0.62, saturation: 0.5, brightness: 0.33)
    static let sunriseStart = Color(hue: 0.62, saturation: 0.6, brightness: 0.42)
    static let sunriseEnd = Color(hue: 0.95, saturation: 0.35, brightness: 0.66)
    static let sunnyDayStart = Color(hue: 0.6, saturation: 0.6, brightness: 0.6)
    static let sunnyDayEnd = Color(hue: 0.6, saturation: 0.4, brightness: 0.85)
    static let sunsetStart = Color.sunriseStart
    static let sunsetEnd = Color(hue: 0.05, saturation: 0.34, brightness: 0.65)
    
    static let darkCloudStart = Color(hue: 0.65, saturation: 0.3, brightness: 0.3)
    static let darkCloudEnd = Color(hue: 0.65, saturation: 0.3, brightness: 0.7)
    static let lightCloudStart = Color.white
    static let lightCloudEnd = Color(white: 0.75)
    static let sunriseCloudStart = Color.lightCloudStart
    static let sunriseCloudEnd = Color.sunriseEnd
    static let sunsetCloudStart = Color.lightCloudStart
    static let sunsetCloudEnd = Color.sunsetEnd
    
}
