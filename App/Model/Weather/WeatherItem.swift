//
//  WeatherItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//


import SwiftUI
import WeatherKit
import Charts


protocol WeatherItem {
    associatedtype Glyph: View
    
    var weather: Weather {get}
    var label: String {get}
    var detail: String? {get}
    
    func data(for hour: HourWeather) -> (Date,Double)
    
    init(weather: Weather)
    
    static var systemName: String {get}
    
    var glyph: Glyph {get}
    
}

extension WeatherItem {
    
    static var title: String { String(describing: Self.self) }
    var symbolName: String {
        Self.systemName
    }
    
    var glyph: some View {
        Image(systemName: symbolName)
            .font(.largeTitle)
    }
    
    func data(from date: Date) -> Double {
        if let hour = weather.hourlyForecast.first(where: { Calendar.current.isDateInHour($0.date) }) {
            return data(for: hour).1
        } else {
            return 0
        }
    }
}

extension WeatherItem {
    
    func data(for range: ClosedRange<Date> = Date.now.startOfDay()...Date.now.endOfDay(), component: Calendar.Component = .hour) -> [(Date,Double)] {
        let hourly = weather.hourlyForecast
        let calendarComponents: Set<Calendar.Component> = {
            switch component {
            case .minute:
                return [.minute, .hour, .day, .month]
            case .hour:
                return [.hour, .day, .month]
            case .day:
                return [.day, .month]
            default:
                return [.day, .month]  // default to day and month if an unsupported component is provided
            }
        }()
        let filtered = hourly
            .filter {
                let componentsOfDate = Calendar.current.dateComponents(calendarComponents, from: $0.date)
                let startComponents = Calendar.current.dateComponents(calendarComponents, from: range.lowerBound)
                let endComponents = Calendar.current.dateComponents(calendarComponents, from: range.upperBound)
                
                // Comparison function
                func isWithinBounds(component: Calendar.Component, from components: DateComponents, between start: DateComponents, and end: DateComponents) -> Bool {
                    guard let currentValue = components.value(for: component),
                          let startValue = start.value(for: component),
                          let endValue = end.value(for: component) else {
                        return false
                    }
                    return currentValue >= startValue && currentValue <= endValue
                }
                
                // Check if the given date's component falls within the range
                return calendarComponents.allSatisfy { isWithinBounds(component: $0, from: componentsOfDate, between: startComponents, and: endComponents) }
            }
        return filtered.map{ data(for: $0) }
    }
//
//    
//    var chart: some View {
//        let chartData = data()
//        return ItemChart(chartPoints: chartData)
//    }
}
