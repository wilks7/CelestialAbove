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
    @Environment(\.dismiss) var dismiss

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
        #if os(iOS)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button(intent: SkyIntent()) {
                    Image(systemName: "map")
                }
//                Button(systemName: "map"){
//                    self.showScene = true
//                }
                .foregroundStyle(.white)
            }
            ToolbarItem(placement: .bottomBar) {

                Button(systemName: "list.bullet") {
//                    withAnimation{
//                        self.dismissSky = nil
//                    }
                    dismiss()
                }
                .foregroundStyle(.white)
            }
        }
        #endif
        .background {
            BackGroundView(sun: sky.weather?.today?.sun, timezone: sky.timezone, time: .now, showClouds: true)
        }
    }
    



}

//
//#Preview {
//    return SkyGridView(sky: sky)
//
//}
