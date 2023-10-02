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


struct CelestialChart: View {
    typealias ChartPoint = (Date, Double)
    
    let celestial: CelestialBody.Type
    
    let locations: [PlanetEvents.Location]
    let observer: CLLocation
    
    @State private var selected: ChartPoint? = nil
    
    var chartPoints: [(Date, Double)] {
        locations.map{ ($0.date, $0.altitude) }
    }
    
    var now: (Date, Double)? {
        (.now, pointFor(.now))
    }
    
    func pointFor(_ date: Date) -> Double {
        CelestialService().celestialLocation(celestial: celestial, at: observer, at: date).altitude
    }
    
    func checkFor(_ date: Date) -> Bool {

        #warning("better guard")
        if let first = chartPoints.first?.0,
           let last = chartPoints.last?.0 {
            
            return date >= first && date <= last
        } else {
            return false
        }
    }
    
    var body: some View {
        ItemChart(points: chartPoints, showZero: true, now: now)
            .selectOverlay(selected: $selected, pointFor: pointFor, checkFor: checkFor)

    }
}

//#Preview {
//    CelestialChart()
//}
