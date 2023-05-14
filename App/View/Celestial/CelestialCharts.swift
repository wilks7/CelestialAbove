//
//  CelestialCharts.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import CoreLocation
import WeatherKit

struct CelestialCharts: View {
    let events: [CelestialEvents]
    let location: CLLocation
    let weather: Weather?
    @State private var time: Date = .now
    @State private var selected: CelestialEvents?
    
    var body: some View {
        ForEach(events){ event in
            VStack {
                HStack(alignment: .center) {
                    PlanetView(celestial: event.title, width: 50, height: 50, interactions: true)
                    Text(event.title)
                        .font(.title2.weight(.semibold))
                        .onTapGesture {
                            self.selected = event
                        }
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
        .sheet(item: $selected) { event in
            SkyItemDetailView(weather: weather, events: events, location: location, item: .venus, selected: weather?.today)
        }
    }
}

struct CelestialCharts_Previews: PreviewProvider {
    static var previews: some View {
        CelestialCharts(events: events, location: sky.location, weather: nil)
    }
}
