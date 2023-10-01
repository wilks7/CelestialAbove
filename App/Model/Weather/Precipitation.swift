//
//  PrecipitationItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import Foundation
import WeatherKit

struct Precipitation: WeatherItem {
    let weather: Weather
    static var systemName: String { "drop" }

    var chance: Double? {
        weather.hour?.precipitationChance
    }
    
    var amount: Measurement<UnitLength>? {
        weather.hour?.precipitationAmount
    }
    
    var value: Double?{ amount?.value }
    

    var label: String {
        chance?.percentString ?? "--"
    }
    
    var detail: String? {
        weather.hour?.precipitation.description
    }
}

extension Precipitation {

    func data(for hour: HourWeather) -> (Date,Double) {
        (hour.date, hour.precipitationAmount.value)
    }
}
