//
//  CloudItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import WeatherKit
import SwiftUI

struct Cloud: WeatherItem {
    
    let weather: Weather
    
    static var systemName: String { "cloud" }

    var condition: WeatherCondition? {
        weather.hour?.condition
    }
    
    var coverage: Double? {
        weather.hour?.cloudCover
    }

    var label: String {
        condition?.description ?? "--"
    }
    
    var detail: String? {
        if let converage = coverage?.percentString {
            return converage + " Coverage"
        } else {
            return nil
        }
    }
    
    func data(for hour: HourWeather) -> (Date,Double) {
        (hour.date, hour.cloudCover)
    }
}
