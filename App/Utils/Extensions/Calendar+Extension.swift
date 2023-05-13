//
//  Calendar+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation

extension Calendar {
    func isDateInHour(_ date: Date) -> Bool {
        let components1 = dateComponents([.year, .month, .day, .hour], from: date)
        let components2 = dateComponents([.year, .month, .day, .hour], from: .now)
        return components1 == components2
    }
    
    func isDateInMinute(_ date: Date) -> Bool {
        let components1 = dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let components2 = dateComponents([.year, .month, .day, .hour, .minute], from: .now)
        return components1 == components2
    }
}
