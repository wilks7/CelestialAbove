//
//  SkyCellView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/17/23.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct SkyCellView: View {
    
    let title: String
    let location: CLLocation
    let timezone: TimeZone
    let weather: Weather?
    
    var events: [CelestialEvents] {
        CelestialService.fetchPlanetEvents(at: location, in: timezone, title: title)
    }
        
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                SkyTitle(title: title, timezone: timezone, font: .title3)
                Spacer()
                
                if let percent = weather?.daily.first?.percent {
                    Text(percent, format: .percent)
                        .font(.system(size: 52))
                        .fontWeight(.light)
                        .offset(y: -8)
                }
            }
            HStack(alignment: .bottom) {
                if let event = events.first {
                        PlanetView(celestial: event.title, interactions: false)
                            .frame(width: 30, height: 30)
                            .offset(y: 5)
                        Text(event.title)
                }
                Spacer()
                if let hour = weather?.hourlyForecast.forecast.first {
                    Text(hour.condition.description.capitalized)

                }
            }
            .font(.subheadline)
            .fontWeight(.medium)
        }
        .foregroundColor(.white.opacity(0.9))
    }
}


extension SkyCellView {
    init(sky: Sky){
        self.title = sky.title
        self.location = sky.location
        self.timezone = sky.timezone
        self.weather = sky.weather
    }
}


#Preview {
    SkyCellView(
        title: "New York",
        location: MockData.locationNY,
        timezone: MockData.timezoneNY,
        weather: MockData.weather
    )
    .padding()
    .background(Color.indigo)
    .clipShape( RoundedRectangle(cornerRadius: 16) )
}
