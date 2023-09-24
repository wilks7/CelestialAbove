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
        
    var events: [CelestialEvents] {
        CelestialService().fetchPlanetEvents(at: sky.location, in: sky.timezone, title: sky.title)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            header
            Grid {
                sunMoon
                GridRow {
                    ForecastView(forecast: weather?.hourly, timezone: sky.timezone)
                        .gridCellColumns(2)
                }
                planetEvents
                GridRow {
                    ForecastView(forecast: weather?.daily, timezone: sky.timezone, alignment: .vertical)
                        .gridCellColumns(2)
                }
                #if !os(watchOS)
                GridRow {
                    LightPollutionCell(location: sky.location)
                        .gridCellColumns(2)
                }
                #endif
                weatherItems
            }
            .padding()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    var header: some View {
        VStack {
            Text(sky.title)
                .font(.largeTitle)
            Text("90%")
                .font(.system(size: 82))
            
        }
    }
    
    var sunMoon: some View {
        GridRow {
            SunMoonView(location: sky.location,
                        timezone: sky.timezone,
                        sunEvents: weather?.today?.sun,
                        moonEvents: weather?.today?.moon
            )
        }
    }
    
    var planetEvents: some View {
        ForEach(events) { event in
            GridRow {
                SkyGridCell(title: event.title, symbolName: event.symbolName) {
                    
                } chart: {
                    ItemChart()
                } sheet: {
                    Text("Detail")
                }
                    .gridCellColumns(2)
            }
        }
    }
    
    @ViewBuilder
    var weatherItems: some View {
        if let weather {
            GridRow {
                SkyGridCell(Cloud.self, weather: weather)
                SkyGridCell(Wind.self, weather: weather)
            }
            GridRow {
                SkyGridCell(Precipitation.self, weather: weather)
                SkyGridCell(Temperature.self, weather: weather)
            }
            GridRow {
                SkyGridCell(Visibility.self, weather: weather)
                SkyGridCell(Percent.self, weather: weather)
            }
        }
    }

}


#Preview {
    ModelPreview { sky in
        var sky:Sky = sky
//        sky.events = MockData.events
//        sky.weather = MockData.weather
        return SkyGridView(sky: sky)
    }
}


struct ItemChart: View {
    var body: some View {
        VStack{}
    }
}
