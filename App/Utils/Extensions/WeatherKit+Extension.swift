//
//  WeatherKit+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import Foundation
import WeatherKit


struct CloudItem: WeatherItem {
    init(_ weather: Weather?) {
        self.hourly = weather?.hourly ?? []
        self.condition = weather?.hour?.condition
        self.coverage = weather?.hour?.cloudCover
    }
    let hourly: [HourWeather]
    let condition: WeatherCondition?
    let coverage: Double?
    
    var title: String { "Clouds" }
    var symbolName: String { "cloud" }
    var label: String? { condition?.description }
    var subtitle: String? { label }
    static func data(for hour: HourWeather) -> WeatherChartData {
        WeatherChartData(date: hour.date, value: hour.cloudCover)
    }

}

struct WindItem: WeatherItem {
    init(_ weather: Weather?) {
        self.hourly = weather?.hourly ?? []
        self.wind = weather?.hour?.wind
    }
    let hourly: [HourWeather]
    let wind: Wind?
    
    var title: String { "Wind" }
    var symbolName: String { "wind" }
    var label: String? {
        guard let wind else {return nil}
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        
        return measurementFormatter.string(from: wind.speed)
    }
    var subtitle: String? {
        wind?.direction.description
    }
    
    static func data(for hour: HourWeather) -> WeatherChartData {
        WeatherChartData(date: hour.date, value: hour.wind.speed.value)
    }
    

}

struct TemperatureItem: SkyItem {
    
    let hourly: [HourWeather]
    
    var temperature: Measurement<UnitTemperature>?
    var high: Measurement<UnitTemperature>?
    var low: Measurement<UnitTemperature>?
    
    let title = "Temperature"
    let symbolName = "thermometer.medium"
    
    static let formatter: MeasurementFormatter = {
        let fmt = MeasurementFormatter()
        fmt.unitStyle = .medium
        fmt.numberFormatter.maximumFractionDigits = 0
        return fmt
    }()
    var label: String? {
        return Self.formatter.string(from: high)
    }
    
    var subtitle: String? {
        "L: \(Self.formatter.string(from: low)) - H: \(Self.formatter.string(from: high))"
    }
    
    var data: [WeatherChartData] {
        guard let hourly else {return []}
        return hourly.map{ .init(date: $0.date, value: $0.temperature.value) }
    }
    static func data(for hour: HourWeather) -> WeatherChartData {
        WeatherChartData(date: hour.date, value: hour.temperature.value)
    }
}


struct PrecipitationItem: SkyItem {
    
    let hourly: [HourWeather]
    let precipitation: WeatherKit.Precipitation
    let chance: Double
    let amount: Double
    
    let title = "Precipitation"
    var symbolName: String { "drop" }

    var label: String? {
        chance.percent?.description
    }
    var subtitle: String? {
        precipitation.description
    }
    
    var data: [WeatherChartData] {
        hourly.map{ .init(date: $0.date, value: $0.precipitationAmount.value) }
    }
}


struct Visibility: SkyItem {
    let hourly: [HourWeather]
    let visibility: Measurement<UnitLength>

    let title = "Visibility"
    var symbolName: String { "eye.fill" }
    var label: String? {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .medium
        measurementFormatter.numberFormatter.maximumFractionDigits = 0

        return measurementFormatter.string(from: visibility)
    }
    
    var subtitle: String? { nil }
    
    var data: [WeatherChartData] {
        hourly.map{ .init(date: $0.date, value: $0.precipitationAmount.value) }
    }

}
    
