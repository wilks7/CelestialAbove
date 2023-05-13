//
//  WeatherItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation
import WeatherKit

protocol WeatherItem: Codable {
    static var title: String {get}
    var symbolName: String {get}
    var label: String {get}
    var subtitle: String? {get}
}
extension WeatherItem {
    var symbolName: String { Self.title.lowercased() }
    var subtitle: String? {nil}
}

extension WeatherItem where Self: Events {
    var subtitle: String? {
        switch self.nextEvent.type {
        case .rise:
            return "Set: " + (set?.time() ?? "--")
        case .set:
            return "Rise: " + (rise?.time() ?? "--")
        case .transit:
            return "Set: " + (set?.time() ?? "--")
        }
    }
}

extension WeatherCondition: WeatherItem {
    static var title: String { "Clouds" }
    var symbolName: String { "cloud" }
    var label: String { description }
}

extension Wind: WeatherItem {
    static var title: String { "Wind" }
    
    var label: String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        
        return measurementFormatter.string(from: speed)
    }
    
    var subtitle: String? {
        self.direction.description
    }
}

extension SunEvents: WeatherItem {
    static var title: String { "Sun"}
    var symbolName: String {
        self.nextEvent.type == .rise ? "sunrise" : "sunset"
    }
    var label: String { nextTime }
}

extension MoonEvents: WeatherItem {
    static var title: String { "Moon"}
    var symbolName: String {
        self.nextEvent.type == .rise ? "moon.haze" : "moon"
    }
    var label: String { nextTime }
}




extension DayWeather {

    struct Temperature: WeatherItem {
        static let title = "Temperature"
        static let formatter: MeasurementFormatter = {
            let fmt = MeasurementFormatter()
            fmt.unitStyle = .medium
            fmt.numberFormatter.maximumFractionDigits = 0
            return fmt
        }()
        var symbolName: String { "thermometer.medium" }
        
        var label: String {
            return Self.formatter.string(from: high)
        }
        
        var subtitle: String? {
            "L: \(Self.formatter.string(from: low)) - H: \(Self.formatter.string(from: high))"
        }
        
        var high: Measurement<UnitTemperature>
        var low: Measurement<UnitTemperature>
    }
    
    struct Precipitation: WeatherItem {
        static let title = "Precipitation"
        var symbolName: String { "drop" }
    
        var label: String {
            chance.percent?.description ?? "--"
        }
        var precipitation: WeatherKit.Precipitation
        var chance: Double
        var subtitle: String? {
            precipitation.description
        }
    }
    

    
    var temperatureItem: Temperature {
        Temperature(high: highTemperature, low: lowTemperature)
    }
    
    var precipitationItem: Precipitation {
        Precipitation(precipitation: precipitation, chance: precipitationChance)
    }
    

}

extension HourWeather {
    struct Visibility: WeatherItem {
        static let title = "Visibility"
        var symbolName: String { "eye.fill" }
        var visibility: Measurement<UnitLength>
        var label: String {
            let measurementFormatter = MeasurementFormatter()
            measurementFormatter.unitStyle = .medium
            measurementFormatter.numberFormatter.maximumFractionDigits = 0

            return measurementFormatter.string(from: visibility)
        }

    }
    
    var visibilityItem: Visibility {
        Visibility(visibility: visibility)
    }
}
