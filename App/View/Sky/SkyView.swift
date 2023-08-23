//
//  SkyView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import WeatherKit

struct SkyView: View {
    @EnvironmentObject var navigation: NavigationManager
    
    let title: String
    let events: [CelestialEvents]
    let weather: Weather?
    let sunrise: Date
    let sunset: Date
    
        
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                header
                ForEach(events) { events in
                    CelestialChartItem(event: events, sunrise: sunrise, sunset: sunset)
                }
                if let weather = weather {
                    WeatherCells(weather)
                }
            }
            .padding(.horizontal)
        }
        .scrollContentBackground(.hidden)
//        .navigationTitle(title ?? "Title")
    }
    
    var header: some View {
        VStack {
            Text(title)
            HStack {
                Spacer()
                Text("90%")
                    .font(.system(size: 82))
                Spacer()
            }
        }
    }
}

extension SkyView {
    init(sky: Sky){
        self.title = sky.title ?? sky.id
        self.events = sky.events
        self.weather = sky.weather
        self.sunset = sky.weather?.today?.sun.sunset ?? Date.now
        self.sunrise = sky.weather?.today?.sun.sunrise ?? Date.now
    }
}

import CoreLocation
import SwiftAA

#Preview {
    let locationNY: CLLocation = CLLocation(latitude: 40.7831, longitude: -73.9712)
    var timezoneNY: TimeZone { TimeZone(identifier: "America/New_York")! }
    let venus = CelestialService().createEvent(for: Venus.self, at: locationNY, in: timezoneNY)
    let sunrise = Date.now.startOfDay().addingTimeInterval(60*60*7)
    let sunset = Date.now.endOfDay().addingTimeInterval(-60*60*7)
    
    return SkyView(title: "Hi", events: MockData.events, weather: nil, sunrise: sunrise, sunset: sunset)
}

//#Preview {
//    ModelPreview {
//        SkyView(sky: $0)
//    }
//}
