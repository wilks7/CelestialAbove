//
//  Weather+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import WeatherKit
import Foundation

extension Weather {
//    var date: Date { currentWeather.date }
    
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
        dailyForecast.forecast
    }
    
    var hourly: [HourWeather] {
        hourlyForecast.forecast
            .filter{ Calendar.current.isDateInToday($0.date) }
    }
    
    var minutely: [MinuteWeather] {
        ( minuteForecast?.forecast ?? [] )
            .filter{ Calendar.current.isDateInHour($0.date) }
    }
}
