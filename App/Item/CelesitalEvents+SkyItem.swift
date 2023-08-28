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
    
    var label: String? { nextTime }
    var subtitle: String? { self.nextEvent.type.rawValue.capitalized  }
    var symbolName: String {"circle"}
    
    var constant: some View {
        PlanetView(celestial: title)
    }
    
    var chartData: [Location] { locations }
        
    func point(for date: Date) -> Location? {
        CelestialService().celestialLocation(.init(celestial: celestial, location: location, date: date))
    }
    
    init?(_ param: Sky) {
        #warning("Change this to NExtEvent")
        guard let first = param.events.first else {return nil}
        self = first
    }
    
    func compact(_ alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment, spacing: 0) {
            constant
                .frame(width: 30, height: 30)
            Text(nextTime ?? "--")
        }
    }
    



}
extension CelestialEvents.Location: ChartData {
    typealias Reference = Date
    var reference: Date { date }
    var value: Double { altitude }
}

