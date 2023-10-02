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
        let type = nextEvent(rise: sunEvents?.sunrise, set: sunEvents?.sunset, transit: sunEvents?.solarNoon).type
        return "Sun" + type.rawValue

    }
    
    var solarMidnight: String {
        sunEvents?.solarMidnight?.time(timezone) ?? ""
    }
    
    var moonTitle: String {
        let type = nextEvent(rise: moonEvents?.moonrise, set: moonEvents?.moonset, transit: nil).type
        return "Moon" + type.rawValue

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
        }
    }

    
    var body: some View {
        ZStack{}
//        SkyGridRow(title: "Sun", symbolName: "sunrise"){
//            ItemSmall(label: sunTitle, detail: solarMidnight) {
//                OffsetContent(label: "Time", subtitle: "Solar Midnight")
//            }
//        } chart: {
//            let locations = CelestialService().fetchLocations(celestial: Sun.self, at: location, in: timezone)
//            ItemChart(chartPoints: locations.map{ ($0.date, $0.altitude) })
//        } sheet: {
//            Text("Sun Sheet")
//        }
//        SkyGridRow(title: "Moon", symbolName: "moon"){
//            ItemSmall(label: sunTitle, detail: solarMidnight) {
//                OffsetContent(label: "Time", subtitle: "")
//            }
//        } chart: {
//            let locations = CelestialService().fetchLocations(celestial: Moon.self, at: location, in: timezone)
//            ItemChart(chartPoints: locations.map{ ($0.date, $0.altitude) })
//
//        } sheet: {
//            Text("Moon Sheet")
//
//        }
    }
}

extension SunMoonView {
    init(sky: Sky){
        self.init(location: sky.location, timezone: sky.timezone, sunEvents: sky.weather?.today?.sun, moonEvents: sky.weather?.today?.moon)
    }
}

#Preview {
    Grid {
        GridRow {
            SunMoonView(location: MockData.locationNY, timezone: MockData.timezoneNY, sunEvents: MockData.sunEvents, moonEvents: MockData.moonEvents)
        }
    }
}
