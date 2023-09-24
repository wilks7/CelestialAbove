//
//  WindItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import SwiftUI
import WeatherKit
import Charts

struct Wind: WeatherItem {
    let weather: Weather
    
    var wind: WeatherKit.Wind? {
        weather.hour?.wind
    }
    
    static var systemName: String {
        "wind"
    }
    
    var label: String {
        guard let wind else {return "--"}
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        return measurementFormatter.string(from: wind.speed)
    }
        
    var detail: String? {
        wind?.compassDirection.description
    }
    
    func data(for hour: HourWeather) -> (Date,Double) {
        (hour.date, hour.wind.speed.value)
    }
}

//#Preview {
//    SmallView(item: MockData.weather.hourly.first!.wind)
//}
