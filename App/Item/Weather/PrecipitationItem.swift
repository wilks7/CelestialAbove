//
//  PrecipitationItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import Foundation
import WeatherKit

struct Precipitation: WeatherItem {
    
    let precipitation: WeatherKit.Precipitation
    let chance: Double
    let amount: Measurement<UnitLength>
    var value: Double { amount.value }
    let chartData: [WeatherChartData]

    init(hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?) {
        self.precipitation = hour.precipitation
        self.chance = hour.precipitationChance
        self.amount = hour.precipitationAmount
        self.chartData = hourly.map{ .init(reference: $0.date, value: $0.precipitationAmount.value) }
    }

    let title = "Precipitation"
    var symbolName: String { "drop" }

    var label: String? {
        value.percent?.description
    }
    var subtitle: String? {
        precipitation.description
    }

}
