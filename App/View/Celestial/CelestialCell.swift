//
//  CelestialCell.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/1/23.
//

import SwiftUI
import CoreLocation

struct CelestialGridRow: View {
    let event: PlanetEvents
    let location: CLLocation
    let timezone: TimeZone
    
    var body: some View {
        GridRow {
            SkyGridRow(title: event.title, symbolName: "circle") {
                ItemMedium(
                    title: "Rises", subtitle: event.rise?.time(timezone),
                    detail: "Transits", subdetail: event.transit?.time(timezone),
                    label: "Sets", sublabel: event.set?.time(timezone)
                ) {
                    PlanetView(celestial: event.title)
                        .frame(width: 75, height: 75)
                }
            } chart: {
                chart
            } sheet: {
                PlanetDetailView(events: event, location: location, timezone: Calendar.current.timeZone)
//                ItemDetailView(title: event.title, symbolName: "circle") {
//                    PlanetView(celestial: event.title)
//                        .frame(width: 200, height: 200)
//
//                } chart: {
//                    chart
//                }
            }
            .gridCellColumns(2)
        }
    }
    
    
    var chart: some View {
        CelestialChart(celestial: event.celestial, locations: event.locations, observer: location)

    }
}

//#Preview {
//    CelestialCell()
//}
