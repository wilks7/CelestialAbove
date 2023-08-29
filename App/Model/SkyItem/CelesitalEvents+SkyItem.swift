//
//  CelesitalEvents+Item.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import Foundation
import Charts
import SwiftUI

extension CelestialEvents: SkyItem {
    
    var glyph: some View {
        PlanetView(celestial: title)
    }
    
    func point(for date: Date) -> Double {
        point(for: date, at: location)
    }
    
    var compact: some View {
        VStack(alignment: .leading, spacing: 0) {
            glyph
                .frame(width: 30, height: 30)
            Text(nextTime ?? "--")
        }
    }
    
    var chart: some View {
        let points = locations.map{($0.date, $0.altitude)}
        return ItemChart(chartPoints: points, showZero: true, pointFor: point(for:) )
    }
    
    func data(for range: ClosedRange<Date>, component: Calendar.Component) -> [(Date,Double)] {
        locations.map{ ($0.date, $0.altitude) }
    }

}
