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
    
    func sameDay(as date: Date = .now, at timezone: TimeZone = Calendar.current.timeZone) -> Bool {
        return self.startOfDay(timezone) == date.startOfDay(timezone)
    }
}

// MARK: - Percent of the Day
extension Date {
    
    func percent(_ timezone: TimeZone) -> Double {
        let start = self.startOfDay(timezone).timeIntervalSince1970
        let end = self.endOfDay(timezone).timeIntervalSince1970
        let current = self.timeIntervalSince1970
        
        return ((current - start) / (end - start))

    }
    
    init(percent double: Double, at timezone: TimeZone){
        let start = Date.now.startOfDay(timezone)
        let advanced = start.addingTimeInterval(double * 24 * 60 * 60)
        self = advanced
    }
}
