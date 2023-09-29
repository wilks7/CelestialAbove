//
//  CelesitalEvents+Item.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import Foundation
import Charts
import SwiftUI

extension CelestialEvents {
    
    typealias Glyph = PlanetView
    var points: [(Date, Double)] {
        locations.map{ ($0.date, $0.altitude) }
    }
    

    
    
    var glyph: some View {
        PlanetView(celestial: title)
    }
    
//    func point(for date: Date) -> Double {
//        point(for: date, at: location)
//    }
    

//    var chart: some View {
//        let points = locations.map{($0.date, $0.altitude)}
//        return ItemChart(chartPoints: points, showZero: true, pointFor: point(for:) )
//    }
    
    func data(for range: ClosedRange<Date>, component: Calendar.Component) -> [(Date,Double)] {
        locations.map{ ($0.date, $0.altitude) }
    }

}
