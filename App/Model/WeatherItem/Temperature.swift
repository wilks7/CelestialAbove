//
//  TemperatureItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import Foundation
import WeatherKit

struct Temperature: WeatherItem {
    let temperature: Measurement<UnitTemperature>
    
    var high: Measurement<UnitTemperature>?
    var low: Measurement<UnitTemperature>?
    
    var value: Double { temperature.value }
    let chartData: [WeatherChartData]

    
    init(hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?) {
        self.temperature = hour.temperature
        self.high = day?.highTemperature
        self.low = day?.lowTemperature
        self.chartData = hourly.map{ .init(reference: $0.date, value: $0.temperature.value) }
    }

    let symbolName = "thermometer.medium"

    static let formatter: MeasurementFormatter = {
        let fmt = MeasurementFormatter()
        fmt.unitStyle = .medium
        fmt.numberFormatter.maximumFractionDigits = 0
        return fmt
    }()
    
    var label: String? {
        return Self.formatter.string(from: temperature)
    }

    var subtitle: String? {
        guard let low, let high else {return nil}
        return "L: \(Self.formatter.string(from: low)) H: \(Self.formatter.string(from: high))"
    }

}
