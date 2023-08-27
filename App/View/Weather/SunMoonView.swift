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

    
    var body: some View {
        SkyGridCell(title: "Sun", symbolName: "sunrise"){
            SmallView(label: sunTitle, subtitle: solarMidnight) {
                VStack(alignment: .leading) {
                    Text(sunEvents?.nextTime ?? "")
                        .font(.largeTitle)
                        .padding(.bottom, 4)
                    Text("Solar Midnight")
                        .offset(y: 6)
                }
            }
        } chart: {
            let locations = CelestialService().fetchLocations(celestial: Sun.self, at: location, in: timezone)
            CelestialChart(celestial: Sun.self, location: location, timezone: timezone, locations: locations)
        }
        SkyGridCell(title: "Moon", symbolName: "moon"){
            SmallView(label: moonTitle, subtitle: moonEvents?.phase.description.capitalized) {
                VStack(alignment: .leading) {
                    Text(sunEvents?.nextTime ?? "")
                        .font(.largeTitle)
                        .padding(.bottom, 4)
                    Image(systemName: moonEvents?.phase.symbolName ?? "moon")
                        .offset(y: 6)
                }
            }
        } chart: {
            let locations = CelestialService().fetchLocations(celestial: Moon.self, at: location, in: timezone)

            CelestialChart(celestial: Moon.self, location: location, timezone: timezone, locations: locations)
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
