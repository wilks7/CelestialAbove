//
//  CloudItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import WeatherKit
import Foundation

struct Cloud: WeatherItem {
    let condition: WeatherCondition
    let cover: Double
    let chartData: [WeatherChartData]
    
    init(hour: HourWeather, _ hourly: [HourWeather], day: DayWeather?) {
        self.condition = hour.condition
        self.cover = hour.cloudCover
        self.chartData = hourly.map{ .init(reference: $0.date, value: $0.cloudCover) }
    }
    var label: String? { condition.description }
    var value: Double { cover }
}
