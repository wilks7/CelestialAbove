//
//  CelestialEventsChart.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import Charts
import SwiftAA
import CoreLocation

struct CelestialEventsChart: View {
    let event: CelestialEvents
    let location: CLLocation
    @Binding var time: Date
    
    @State private var selected: CelestialEvents.Location?
    
    var body: some View {
        Chart {
            if let selected {
                RuleMark(x: .value("Time", selected.date))
                    .foregroundStyle(.gray)
            }
            ForEach(event.data){
                LineMark(
                    x: .value("Time", $0.date),
                    y: .value("Altitude", $0.altitude),
                    series: .value("Alt", "A")
                )
                .foregroundStyle(event.color)
                .lineStyle(.init(lineWidth: 4))
            }
            if let selected {
                PointMark(
                    x: .value("Time", selected.date),
                    y: .value("Value", selected.altitude)
                )
                .foregroundStyle(.white)
            } else {
                PointMark(
                    x: .value("Time", time),
                    y: .value("Value", getLocation(at: time)
                        .altitude)
                )
                .foregroundStyle(.white)
            }
        }
    }
    
    private func getLocation(at date: Date) -> CelestialEvents.Location {
        CelestialService().celestialLocation(.init(celestial: event.celestial, location: location, date: date))
    }
}

struct CelestialEventsChart_Previews: PreviewProvider {
    static var previews: some View {
        CelestialEventsChart(event: event, location: sky.location, time: .constant(Date.now))
    }
}
