//
//  CelestialChart.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 9/29/23.
//

import SwiftUI
import Charts
import CoreLocation
import SwiftAA
import MultiItem

struct PlanetChart: View {
    let events: PlanetEvents
    var date: Date = .now
    var selectable: Bool = false
    
    @State private var selected: (Date, Double)? = nil
    
    var now: (Date, Double) {
        (date, pointFor(date))
    }
    
    func pointFor(_ date: Date) -> Double {
        CelestialService.celestialLocation(celestial: events.celestial, at: events.observer, at: date).altitude
    }

    var body: some View {
        if selectable {
            ItemChart(item: events, showZero: true, selected: $selected, now: now)
                .selectOverlay(selected: $selected, pointFor: pointFor, checkFor: checkFor)
        } else {
            ItemChart(item: events, showZero: true, selected: $selected, now: now)
        }


    }
    
    
    func checkFor(_ date: Date) -> Bool {

        #warning("better guard")
        if let first = events.locations.first?.date,
           let last = events.locations.last?.date {
            
            return date >= first && date <= last
        } else {
            return false
        }
    }

}

//#Preview {
//    CelestialChart()
//}
