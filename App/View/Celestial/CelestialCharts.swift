//
//  CelestialCharts.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import CoreLocation

struct CelestialCharts: View {
    let events: [CelestialEvents]
    let location: CLLocation
    @State private var time: Date = .now
    var body: some View {
        ForEach(events){ event in
            VStack {
                HStack(alignment: .center) {
                    PlanetView(celestial: event.name, width: 50, height: 50, interactions: true)
                    Text(event.name)
                        .font(.title2.weight(.semibold))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Rise: " + (event.rise?.time() ?? "--"))
                        Text("Set: " + (event.set?.time() ?? "--"))
                    }
                    .font(.subheadline)
                    
                }
                .padding([.horizontal, .top], 6)
                CelestialEventsChart(event: event, location: location, time: $time)
            }
        }
        .transparent()
    }
}

struct CelestialCharts_Previews: PreviewProvider {
    static var previews: some View {
        CelestialCharts(events: events, location: sky.location)
    }
}
