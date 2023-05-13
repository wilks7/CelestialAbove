//
//  WeatherItem.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation

protocol WeatherItem {
    static var title: String {get}
    var symbolName: String {get}
    var label: String {get}
    var subtitle: String? {get}
}
extension WeatherItem {
    var symbolName: String { Self.title.lowercased() }
    var subtitle: String? {nil}
}

extension WeatherItem where Self: Events {
    var subtitle: String? {
        switch self.nextEvent.type {
        case .rise:
            return "Set: " + (set?.time() ?? "--")
        case .set:
            return "Rise: " + (rise?.time() ?? "--")
        case .transit:
            return "Set: " + (set?.time() ?? "--")
        }
    }
}
