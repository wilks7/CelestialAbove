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
    
    typealias CharPoint = (Date, Double)
    
    let celestial: CelestialBody.Type
    
    let locations: [PlanetEvents.Location]
    let observer: CLLocation
    let timezone: TimeZone
    
    var chartPoints: [CharPoint] {
        locations.map{ ($0.date, $0.altitude) }
    }
    
    var now: CharPoint? {
        (.now, pointFor(.now))
    }
    
    func pointFor(_ date: Date) -> Double {
        CelestialService().celestialLocation(celestial: celestial, at: observer, at: date).altitude
    }
    
    var body: some View {
        ItemChart(chartPoints: chartPoints, now: now, pointFor: pointFor, showZero: true)
    }
}


//#Preview {
//    CelestialChart()
//}
