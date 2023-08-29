//
//  TemperatureItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import SwiftUI
import WeatherKit

struct Temperature {
    
    let weather: Weather
    
    static let formatter: MeasurementFormatter = {
        let fmt = MeasurementFormatter()
        fmt.unitStyle = .medium
        fmt.numberFormatter.maximumFractionDigits = 0
        return fmt
    }()

    
    var label: String {
        if let temperature = weather.hour?.temperature {
            return Self.formatter.string(from: temperature)
        } else {
            return "--"
        }
    }
    
    var detail: String? {
        guard let low = weather.today?.lowTemperature,
                let high = weather.today?.highTemperature
        else {return nil}
        
        return "L: \(Self.formatter.string(from: low)) H: \(Self.formatter.string(from: high))"
    }

}

extension Temperature: WeatherItem {
    
    static var systemName: String {
        "thermometer.medium"
    }
    

    
    func data(for hour: HourWeather) -> (Date,Double) {
        (hour.date, hour.temperature.value)
    }

}


#Preview {
    Temperature(weather: MockData.weather).glyph
}
