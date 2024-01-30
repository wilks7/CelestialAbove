//
//  SkyGridView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/26/23.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct SkyGridView: View {
    let sky: Sky
    var weather: Weather? { sky.weather }
        
    var events: [PlanetEvents] {
        CelestialService.fetchPlanetEvents(at: sky.location, in: sky.timezone, title: sky.title)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack {
                    Text(sky.title)
                        .font(.largeTitle)
                    Text(0.9, format: .percent)
                        .font(.system(size: 82))
                }
                Grid {
                    GridRow {
                        SunMoonView(sky: sky)
                    }
                    GridRow {
                        SkyGridRow(title: "Hourly", symbolName: "clouds") {
                            ForecastView(forecast: weather?.hourly, timezone: sky.timezone)
                            .padding(.top, 4)
                        }
                        .gridCellColumns(2)

                    }
                    PlanetGridItems(events: events, sunEvents: weather?.today?.sun)
                    GridRow {
                        SkyGridRow(title: "Daily", symbolName: "clouds") {
                            ForecastView(forecast: weather?.daily, timezone: sky.timezone, alignment: .vertical)
                        }
                        .gridCellColumns(2)
                    }
                    #if !os(watchOS)
                    GridRow {
                        LightPollutionCell(location: sky.location)
                            .gridCellColumns(2)
                    }
                    #endif
                    WeatherItems(weather: weather)
                }
                .padding()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    



}

//
//#Preview {
//    return SkyGridView(sky: sky)
//
//}
