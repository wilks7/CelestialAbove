//
//  StatusMedium.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 10/7/23.
//

import SwiftUI
import WeatherKit

struct StatusMedium: View {
    let sky: SkyEntity
    let display: DisplayData
    let event: PlanetEvents
    
    var weather: Weather? {
        guard let data = sky.weatherData else {return nil}
        return try? JSONDecoder().decode(Weather.self, from: data)
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                StatusTitle(title: sky.title, timezone: sky.timezone)

                Spacer()
                VStack(alignment: .trailing){
                    Text(0.6, format: .percent)
                    if display == DisplayData.planet {
                        Image(systemName: "cloud")
                        Text("Cloud")
                            .font(.callout)
                    } else {
                        eventDetails
                    }
                }
            }
            if display == DisplayData.planet {
                PlanetChart(events: event)
            } else if let weather {
                ForecastView(forecast: weather.hourly, timezone: sky.timezone, sunEvents: weather.today?.sun, alignment: .horizontal, items: 4)
            } else {
                PlanetChart(events: event)
            }
            
        }
    }
    
    var eventDetails: some View {
        VStack(alignment: .leading, spacing: 5) {
            Image(systemName: "circle.fill")
                .foregroundStyle(event.color)
//            Text(event.title)
                .font(.callout)
            if let transit = event.transit {
                Text(transit.time(sky.timezone))
                    .font(.caption)
            }
            HStack(spacing: 0) {
                if let rise = event.rise {
                    Image(systemName: "arrow.up")
                        .font(.caption2)
                    Text(rise.time(sky.timezone))
                        .font(.caption)

                }
                Spacer()
                if let set = event.set {
                    Image(systemName: "arrow.down")
                        .font(.caption2)
                    Text(set.time(sky.timezone))
                        .font(.caption)
                }
            }
        }
        .fontWeight(.semibold)
        .lineLimit(1)
        .minimumScaleFactor(0.7)
    }
}

//#Preview {
//    StatusMedium()
//}
