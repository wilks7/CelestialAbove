//
//  Weather+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import WeatherKit
import Foundation

extension Weather {
    var date: Date { currentWeather.date }
    
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
        hourlyForecast.forecast.filter{ Calendar.current.isDateInToday($0.date) }
    }
    
    var minutely: [MinuteWeather] {
        guard let minuteForecast else {return []}
        return minuteForecast.forecast.filter{ Calendar.current.isDateInHour($0.date) }
    }
}

// MARK: Items
//extension Weather {
//    
//    var percent: Percent? {
//        guard let today, let hour else {return nil}
//        return .init(hour: hour, hourly, day: today)
//    }
//    
//    var wind: Wind? {
//        guard let today, let hour else {return nil}
//        return .init(hour: hour, hourly, day: today)
//    }
//    
//    var clouds: Cloud? {
//        guard let today, let hour else {return nil}
//        return .init(hour: hour, hourly, day: today)
//    }
//    
//    var temperature: Temperature? {
//        guard let today, let hour else {return nil}
//        return .init(hour: hour, hourly, day: today)
//    }
//    
//    var precipitation: Precipitation? {
//        guard let today, let hour else {return nil}
//        return .init(hour: hour, hourly, day: today)
//    }
//    
//    var visibility: Visibility? {
//        guard let today, let hour else {return nil}
//        return .init(hour: hour, hourly, day: today)
//    }
//}

extension Array where Element == HourWeather {
    var now: Element? {
        first(where: { Calendar.current.isDateInHour($0.date) })
    }
}
