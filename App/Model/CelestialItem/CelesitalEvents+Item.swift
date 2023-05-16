//
//  CelesitalEvents+Item.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/15/23.
//

import Foundation
import Charts
import SwiftUI

extension CelestialEvents: Item {
        
    var label: String? { self.nextEvent.type.rawValue.capitalized }
    var subtitle: String? { nextEvent.date?.time() }
    var symbolName: String {"circle"}
    
    var detail: String? { nil }
    
    var detailSubtitle: String? { nil }
        
    var constant: some View {
        PlanetView(celestial: title)
    }
    
    var chart: some ChartContent {
        ForEach(locations){
            LineMark(
                x: .value("Time", $0.reference),
                y: .value("Value", $0.value),
                series: .value("Alt", "A")
            )
            .lineStyle(.init(lineWidth: 4))
        }
    }
    

}
