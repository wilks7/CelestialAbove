//
//  WeatherKit+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/13/23.
//

import SwiftUI
import WeatherKit


struct Visibility: WeatherItem {
    let weather: Weather
    
    var visibility: Measurement<UnitLength>? {
        weather.hour?.visibility
    }
    
    static var systemName: String { "eye.fill" }

    
    var label: String {
        guard let visibility else {return "--"}
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .medium
        measurementFormatter.numberFormatter.maximumFractionDigits = 0

        return measurementFormatter.string(from: visibility)
    }

    var detail: String? { "Good Visibility" }
    
    func data(for hour: HourWeather) -> (Date,Double) {
        (hour.date, hour.visibility.value)
    }

}

