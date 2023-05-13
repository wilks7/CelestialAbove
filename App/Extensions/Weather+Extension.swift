//
//  Weather+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import WeatherKit
import Foundation

extension Weather {
    var today: DayWeather? {
        dailyForecast.first{ Calendar.current.isDateInToday($0.date) }
    }
    var hour: HourWeather? {
        hourlyForecast.first{ Calendar.current.isDateInHour($0.date) }
    }
    var now: MinuteWeather? {
        minuteForecast?.first{ Calendar.current.isDateInMinute($0.date) }
    }
    
    var daily: [DayWeather] {
        Array(dailyForecast.forecast.prefix(8))
    }
    
    var hourly: [HourWeather] {
        hourlyForecast.forecast.filter{ Calendar.current.isDateInToday($0.date) }
    }
    
    var minutely: [MinuteWeather] {
        guard let minuteForecast else {return []}
        return minuteForecast.forecast.filter{ Calendar.current.isDateInHour($0.date) }
    }
}
