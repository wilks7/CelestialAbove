//
//  WindItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI
import WeatherKit

struct Wind: WeatherItem {
    let wind: WeatherKit.Wind
    var value: Double { wind.speed.value }
    let chartData: [WeatherChartData]

    init(hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?) {
        self.wind = hour.wind
        self.chartData = hourly.map{ .init(reference: $0.date, value: $0.wind.speed.value) }
    }
    
    var label: String? {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        return measurementFormatter.string(from: wind.speed)
    }
    
    var subtitle: String? {
        wind.compassDirection.description
    }

}
