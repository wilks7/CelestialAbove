//
//  MockData.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation
import WeatherKit
import CoreData


extension MockData {
    
    static var forecast: [MockWeather] { makeForecast(for: .day) }
    
    struct MockWeather: WeatherProtocol {
        var date: Date
        
        var percent: Double
        
        var condition: WeatherCondition
        
        var symbolName: String
        
    }
    
    static func makeForecast(for component: Calendar.Component) -> [MockWeather] {
        let now = Date.now
        var forecast: [MockWeather] = []
        for i in 1..<11 {
            if let date = Calendar.current.date(byAdding: component, value: i, to: now) {
                let weather = MockData.MockWeather(date: date, percent: 0.5, condition: .cloudy, symbolName: "circle")
                forecast.append(weather)
            }
        }
        return forecast
    }
}
