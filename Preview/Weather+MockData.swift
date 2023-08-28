//
//  Weather+MockData.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/28/23.
//

import Foundation
import WeatherKit

extension MockData {
    static var clouds: Cloud {
        Cloud(condition: .cloudy, cover: 0.4, chartData: makeClouds())
    }
    
    static func makeClouds(for component: Calendar.Component = .hour) -> [WeatherChartData] {
        let now = Date.now
        var chartData: [WeatherChartData] = []
        for i in 1..<11 {
            if let date = Calendar.current.date(byAdding: component, value: i, to: now) {
                let weather = WeatherChartData(reference: date, value: Double.random(in: 0...1.0))
                chartData.append(weather)
            }
        }
        return chartData
    }
}
