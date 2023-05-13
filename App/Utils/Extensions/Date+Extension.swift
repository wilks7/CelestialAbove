//
//  Date+Extension.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import Foundation

extension Date {
    func time(_ timezone: TimeZone = Calendar.current.timeZone)->String {
        let format = Date.FormatStyle(date: .omitted, time: .shortened, timeZone: timezone)
        return self.formatted(format)
    }
    
    func startOfDay(_ timezone: TimeZone = Calendar.current.timeZone) -> Date {
        var calendar = Calendar(identifier: Calendar.current.identifier)
        calendar.timeZone = timezone
        return calendar.startOfDay(for: self)
    }
    
    func endOfDay(_ timezone: TimeZone = Calendar.current.timeZone) -> Date {
        var calendar = Calendar(identifier: Calendar.current.identifier)
        calendar.timeZone = timezone
        
        var components = DateComponents()
        components.day = 1
        components.second = -1
        
        return calendar.date(byAdding: components, to: startOfDay(timezone))!
    }
}
