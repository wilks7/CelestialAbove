//
//  SkyView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/11/23.
//

import SwiftUI
import WeatherKit

struct SkyView: View {
    let title: String
    let events: [CelestialEvents]
    let timezone: TimeZone
    let weather: Weather?
    let sunEvents: SunEvents?
    let moonEvents: MoonEvents?
    let color: SwiftUI.Color
    
        
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                header
                SunMoonView(sunEvents: sunEvents, moonEvents: moonEvents)
                ForecastView(forecast: weather?.hourly, timezone: timezone)
                ForEach(events) { events in
                    CelestialChartItem(event: events, sunrise: sunEvents?.sunrise, sunset: sunEvents?.sunset)
                }
                ForecastView(forecast: weather?.daily, timezone: timezone, sunEvents: sunEvents, alignment: .vertical)
//                if let weather = weather {
//                    WeatherCells(weather)
//                }
            }
            .padding(.horizontal)
        }
        .scrollContentBackground(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        .background(color)
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
        self.sunEvents = sky.weather?.today?.sun
        self.moonEvents = sky.weather?.today?.moon
        self.timezone = sky.timezone
        self.color = sky.color
    }
}

#Preview {
    ModelPreview { sky in
        var sky:Sky = sky
        sky.events = MockData.events
        return SkyView(sky: sky)
    }
}
#Preview {
    SkyView(title: "Title",
            events: MockData.events,
            timezone: MockData.timezoneNY,
            weather: nil,
            sunEvents: MockData.sunEvents,
            moonEvents: MockData.moonEvents,
            color: .blue
    )
}
