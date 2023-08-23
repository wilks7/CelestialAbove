//
//  CelestialChart.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/16/23.
//

import SwiftUI
import Charts

struct CelestialChart: View {
    let event: CelestialEvents
    @State var selected: CelestialEvents.Location?
    
    var body: some View {
        Chart {
            if let selected {
                selected.rulemark
                    .foregroundStyle(.gray)
            }
            ForEach(event.locations){
                $0.linemark
                .lineStyle(.init(lineWidth: 4))
            }
            if let selected {
                selected.point
                .foregroundStyle(.white)
            } else {
                PointMark(
                    x: .value("Time", Date.now),
                    y: .value("Value", value(for: Date.now).reference)
                )
                .foregroundStyle(.white)
            }
        }
    }
    
    func value(for date: Date) -> CelestialEvents.Location {
        CelestialService().celestialLocation(.init(celestial: event.celestial, location: event.location, date: date))
    }
}

struct CelestialChart_Previews: PreviewProvider {
    static var previews: some View {
        CelestialChart(event: event)
    }
}
