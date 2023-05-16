//
//  WeatherItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Charts
import WeatherKit
import SwiftUI

struct WeatherChartData: Identifiable {
    var id: Date { reference }
    let reference: Date
    let value: Double
}

protocol WeatherItem: Item {
    var hourly: [HourWeather] {get}
    var value: Double? {get}
    init(_ weather: Weather)
    static func value(for hour: HourWeather) -> Double
}

extension WeatherItem {
    var label: String? {symbolName}
    var subtitle: String? {symbolName}
    var detail: String? {symbolName}
    var detailSubtitle: String? {symbolName}
}


extension WeatherItem {

    var now: HourWeather? { hourly.now }
    
    var value: Double? {
        guard let now else {return nil}
        return Self.value(for: now)
    }
    
    var data: [WeatherChartData] {
        hourly.map { hour in
            let data = Self.value(for: hour)
            return .init(reference: hour.date, value: data)
        }
    }
    
    var chart: some ChartContent {
        ForEach(data){
            LineMark(
                x: .value("Time", $0.reference),
                y: .value("Value", $0.value),
                series: .value("Alt", "A")
            )
            .lineStyle(.init(lineWidth: 4))
        }
    }
    
    var constant: some View {
        WeatherValueView(symbolName: symbolName)
    }
}

struct WeatherValueView: View {
    let symbolName: String
    var body: some View {
        Image(systemName: symbolName).resizable().aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
