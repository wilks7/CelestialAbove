//
//  WeatherKit+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit

struct Visibility: WeatherItem {
    let visibility: Measurement<UnitLength>
    let date: Date
    var value: Double { visibility.value }
    let chartData: [WeatherChartData]
    
    init(hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?) {
        self.date = hour.date
        self.visibility = hour.visibility
        self.chartData = hourly.map{ .init(reference: $0.date, value: $0.visibility.value) }

    }
    
    var symbolName: String { "eye.fill" }
    var label: String? {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .medium
        measurementFormatter.numberFormatter.maximumFractionDigits = 0

        return measurementFormatter.string(from: visibility)
    }

    var subtitle: String? { "Good Visibility" }

}

