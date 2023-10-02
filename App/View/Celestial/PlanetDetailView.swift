//
//  PlanetDetailView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/1/23.
//

import SwiftUI
import SwiftAA
import CoreLocation

struct PlanetDetailView: View {
    let events: PlanetEvents
    let location: CLLocation
    let timezone: TimeZone
    
    @State private var time = Date.now
    
    var horizontalCoordinates: HorizontalCoordinates {
        CelestialService().makeHorizontalCoordinates(for: events.celestial, at: location, at: time)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    PlanetView(celestial: events.title)
                        .frame(width: 200, height: 200)
                    Grid {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Events")
                            Divider()
                        }
                        .font(.title)
                        times
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Properties")
                            Divider()
                        }
                        .font(.title)
                        properties
                    }
                }
            }
            .navigationTitle(events.title)
        }
    }
    
    @ViewBuilder
    var times: some View {
        GridRow {
            Text("Rises")
            Text(events.rise?.time(timezone) ?? "--")
        }
        .gridCellAnchor(.leading)
        GridRow {
            Text("Tranists")
            Text(events.transit?.time(timezone) ?? "--")
        }
        .gridCellAnchor(.leading)
        GridRow {
            Text("Sets")
            Text(events.set?.time(timezone) ?? "--")
        }
        .gridCellAnchor(.leading)
    }
    
    @ViewBuilder
    var properties: some View {
        GridRow {
            Text("Right Ascension")
            Text(events.rise?.time(timezone) ?? "--")
        }
        .gridCellAnchor(.leading)
        GridRow {
            Text("Declination")
            Text(events.transit?.time(timezone) ?? "--")
        }
        .gridCellAnchor(.leading)
        GridRow {
            Text("Altitude")
            Text(horizontalCoordinates.altitude.inHours.description)
        }
        .gridCellAnchor(.leading)
        GridRow {
            Text("Azimuth")
            Text(horizontalCoordinates.azimuth.inHours.description)
        }
        .gridCellAnchor(.leading)
    }
}

#Preview {
    PlanetDetailView(events: MockData.mars, location: MockData.locationNY, timezone: MockData.timezoneNY)
}
