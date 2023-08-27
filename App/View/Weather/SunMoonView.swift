//
//  SunMoonView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/26/23.
//

import SwiftUI
import WeatherKit
struct SunMoonView: View {
    
    let sunEvents: SunEvents?
    let moonEvents: MoonEvents?
    
    var body: some View {
        SkyGridCell(title: sunEvents?.title ?? "Sun", symbolName: "sunrise") {
            SmallView(label: sunEvents?.title, subtitle: sunEvents?.nextTime) {
                Image(systemName: "sunrise")
            }
        }
        SkyGridCell(title: moonEvents?.title ?? "Moon", symbolName: "sunrise") {
            SmallView(label: moonEvents?.title, subtitle: moonEvents?.nextTime) {
                Image(systemName: "moon.stars")
            }
        }
    }
}

#Preview {
    SunMoonView(sunEvents: MockData.sunEvents, moonEvents: MockData.moonEvents)
}
