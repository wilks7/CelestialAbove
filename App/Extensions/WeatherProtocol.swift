//
//  Weather.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation
import WeatherKit

protocol WeatherProtocol: Codable, Equatable, Identifiable {
    var date: Date {get}
    var percent: Double {get}
    var condition: WeatherCondition {get}
    var symbolName: String {get}
}

extension WeatherProtocol { public var id: Date { date } }

extension DayWeather: WeatherProtocol {
    var percent: Double { precipitationChance }
}
extension HourWeather: WeatherProtocol {
    var percent: Double { cloudCover }
}

extension CurrentWeather: WeatherProtocol {
    var percent: Double { (cloudCover + humidity) / 2 }
}

extension MinuteWeather: WeatherProtocol {
    var percent: Double {
        self.precipitationChance
    }
    
    var conditionString: String {
        self.precipitation.description
    }
    
    var condition: WeatherCondition {
        if let condition = WeatherCondition(rawValue: precipitation.rawValue) {
            return condition
        } else if self.precipitation == .mixed {
            return .wintryMix
        } else {
            return .clear
        }
    }
    
    var symbolName: String {
        switch self.precipitation {
        case .none:
            return "circle"
        case .hail:
            return "circle"
        case .mixed:
            return "circle"
        case .rain:
            return "circle"
        case .sleet:
            return "circle"
        case .snow:
            return "circle"
        @unknown default:
            return "circle"
        }
    }
}
