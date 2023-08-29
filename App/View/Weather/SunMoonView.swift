//
//  SunMoonView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/26/23.
//

import SwiftUI
import WeatherKit
import SwiftAA
import CoreLocation

struct SunMoonView: View {
    let location: CLLocation
    let timezone: TimeZone
    
    let sunEvents: SunEvents?
    let moonEvents: MoonEvents?
    
    var sunTitle: String {
        if let type = sunEvents?.nextEvent.type {
            return "Sun" + type.rawValue
        } else {
            return ""
        }
    }
    
    var solarMidnight: String {
        sunEvents?.solarMidnight?.time(timezone) ?? ""
    }
    
    var moonTitle: String {
        if let type = sunEvents?.nextEvent.type {
            return "Moon" + type.rawValue
        } else {
            return ""
        }
    }
    
    struct OffsetContent: View {
        let label: String?
        let subtitle: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(label ?? "")
                    .font(.largeTitle)
                    .padding(.bottom, 4)
                Text(subtitle)
                    .offset(y: 6)
            }
//            VStack(alignment: .leading) {
//                Text(sunEvents?.nextTime ?? "")
//                    .font(.largeTitle)
//                    .padding(.bottom, 4)
//                Image(systemName: moonEvents?.phase.symbolName ?? "moon")
//                    .offset(y: 6)
//            }
        }
    }

    
    var body: some View {
        SkyGridCell(title: "Sun", symbolName: "sunrise"){
            SmallView(title: sunTitle, detail: solarMidnight, constant: OffsetContent(label: sunEvents?.nextTime, subtitle: "Solar Midnight"))
        } chart: {
            let locations = CelestialService().fetchLocations(celestial: Sun.self, at: location, in: timezone)
            ItemChart(chartPoints: locations.map{ ($0.date, $0.altitude) })
        } sheet: {
            Text("Sun Sheet")
        }
        SkyGridCell(title: "Moon", symbolName: "moon"){
            SmallView(title: moonTitle, detail: moonEvents?.phase.description.capitalized, constant: OffsetContent(label: moonEvents?.nextTime, subtitle: ""))
        } chart: {
            let locations = CelestialService().fetchLocations(celestial: Moon.self, at: location, in: timezone)
            ItemChart(chartPoints: locations.map{ ($0.date, $0.altitude) })

        } sheet: {
            Text("Moon Sheet")

        }
    }
}

#Preview {
    Grid {
        GridRow {
            SunMoonView(location: MockData.locationNY, timezone: MockData.timezoneNY, sunEvents: MockData.sunEvents, moonEvents: MockData.moonEvents)
        }
    }
}
