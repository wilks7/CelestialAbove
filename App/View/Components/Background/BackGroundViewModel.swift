//
//  BackGroundViewModel.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/7/23.
//

import SwiftUI
import WeatherKit

class BackGroundViewModel: ObservableObject {
    @Published var colors: [Color]
    let sun: SunEvents?
    let timezone: TimeZone
    
    init(sun: SunEvents?, timezone: TimeZone, time: Date = .now) {
        self.sun = sun
        self.timezone = timezone
        self.colors = Color.colors(for: sun, timezone: timezone, at: time)
    }
    
    init(colors: [Color]) {
        self.colors = colors
        self.sun = nil
        self.timezone = Calendar.current.timeZone
    }
    
    
    @MainActor
    func changeColor(date: Date) {
        let colors = Color.colors(for: sun, timezone: timezone, at: date)
        print("\n")
        print(date.formatted())
        print("[\(colors.first?.description ?? ""), \(colors.last?.description ?? "")]")
        print("\n")
        self.colors = colors
    }
    
//    func changeColor
}
