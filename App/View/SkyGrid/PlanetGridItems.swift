//
//  CelestialCell.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/1/23.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct PlanetGridItems: View {
    let events: [PlanetEvents]
    var sunEvents: SunEvents? = nil
    var collumns: Int = 2
    
    var visible: [PlanetEvents] {
        guard let sunEvents else {return events}
        return events.filter {
            $0.isVisible(with: sunEvents)
        }
    }

    var body: some View {
        ForEach(visible) { event in
            GridRow {
                CelestialGridRow(event: event)
                    .gridCellColumns(collumns)
            }
        }
    }
}

fileprivate extension PlanetGridItems {
    struct CelestialGridRow: View {
        let event: PlanetEvents
            
        var body: some View {
            SkyGridRow(title: event.title) {
                ItemMedium(item: event)
            } chart: {
                PlanetChart(events: event)
            } sheet: {
                PlanetDetailView(events: event, location: event.observer, timezone: event.timezone)
            }
        }

    }
}




#Preview {
    Grid {
        PlanetGridItems(events: MockData.events)
    }
}

#Preview {
    PlanetGridItems.CelestialGridRow(event: MockData.mars)
}
