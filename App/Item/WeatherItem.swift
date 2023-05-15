//
//  WeatherItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation
import WeatherKit
import SwiftUI

struct WeatherChartData:ItemChartData {
    let reference: Date
    let value: Double
}

protocol WeatherItem: Item {
    var hourly: [HourWeather] {get}
    init(_ weather: Weather)
    static func data(for hour: HourWeather) -> WeatherChartData
}
extension WeatherItem {
    var data: [WeatherChartData] {
        hourly.map{ Self.data(for: $0) }
    }
    
    func dataFor(_ date: Date) -> Double {
        if let first = hourly.first{$0.date.hour == date.hour} {
            return Self.data(for: first).value
        } else {
            #warning("fix this")
            return 0
        }
        
    }
    
}

struct WeatherValueView<W:WeatherItem>: ItemValueView {
    let item: W
    var body: some View {
        Image(systemName: item.symbolName).resizable().aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}
