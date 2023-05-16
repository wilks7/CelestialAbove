//
//  WeatherKit+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit
import Charts


struct WindItem: WeatherItem {
    let hourly: [HourWeather]
    
    init(_ weather: Weather) { self.hourly = weather.hourly }

    var title: String { "Wind" }
    var symbolName: String { "wind" }
        
    var label: String? {
        guard let wind = now?.wind else {return nil}
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        return measurementFormatter.string(from: wind.speed)
    }
    
    static func value(for hour: HourWeather) -> Double {
        hour.wind.speed.value
    }
}


struct CloudItem: WeatherItem {
    let hourly: [HourWeather]
    init(_ weather: Weather) { self.hourly = weather.hourly }

    static func value(for hour: HourWeather) -> Double {
        hour.cloudCover
    }

    var title: String { "Clouds" }
    var symbolName: String { "cloud" }
    var label: String? { now?.condition.description }
}
//
//
//
struct TemperatureItem: WeatherItem {
    static func value(for hour: HourWeather) -> Double {
        hour.temperature.value
    }
    

    let hourly: [HourWeather]
    
    var temperature: Measurement<UnitTemperature>?
    
    var high: Measurement<UnitTemperature>?
    var low: Measurement<UnitTemperature>?

    init(_ weather: Weather) {
        self.hourly = weather.hourly
        self.temperature = weather.hour?.temperature
        self.high = weather.today?.highTemperature
        self.low = weather.today?.lowTemperature
    }

    let title = "Temperature"
    let symbolName = "thermometer.medium"

    static let formatter: MeasurementFormatter = {
        let fmt = MeasurementFormatter()
        fmt.unitStyle = .medium
        fmt.numberFormatter.maximumFractionDigits = 0
        return fmt
    }()
    
    var label: String? {
        guard let high else {return nil}
        return Self.formatter.string(from: high)
    }

    var subtitle: String? {
        guard let low, let high else {return nil}
        return "L: \(Self.formatter.string(from: low)) - H: \(Self.formatter.string(from: high))"
    }

}

struct PrecipitationItem: WeatherItem {
    static func value(for hour: HourWeather) -> Double {
        hour.precipitationAmount.value
    }
    
    
    init(_ weather: Weather) {
        self.hourly = weather.hourly
        self.precipitation = weather.hour?.precipitation
        self.chance = weather.hour?.precipitationChance
        self.amount = weather.hour?.precipitationAmount.value
    }
    let hourly: [HourWeather]
    let precipitation: WeatherKit.Precipitation?
    let chance: Double?
    let amount: Double?

    let title = "Precipitation"
    var symbolName: String { "drop" }

    var label: String? {
        chance?.percent?.description
    }
    var subtitle: String? {
        precipitation?.description
    }

}


struct Visibility: WeatherItem {
    static func value(for hour: HourWeather) -> Double {
        hour.visibility.value
    }
    

    init(_ weather: Weather) {
        self.hourly = weather.hourly
        self.visibility = weather.hour?.visibility
    }
    let hourly: [HourWeather]
    let visibility: Measurement<UnitLength>?

    let title = "Visibility"
    var symbolName: String { "eye.fill" }
    var label: String? {
        guard let visibility else {return nil}
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .medium
        measurementFormatter.numberFormatter.maximumFractionDigits = 0

        return measurementFormatter.string(from: visibility)
    }

    var subtitle: String? { "Good Visibility" }

}

