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
        CelestialService().fetchPlanetEvents(at: sky.location, in: sky.timezone, title: sky.title)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            header
            Grid {
                GridRow {
                    SunMoonView(sky: sky)
                }
                GridRow {
                    SkyGridRow(title: "Hourly", symbolName: "circle") {
                        ForecastView(forecast: weather?.hourly, timezone: sky.timezone)
                        .padding(.top, 4)
                    }
                    .gridCellColumns(2)

                }
                ForEach(events) { event in
                    GridRow {
                        SkyGridRow(event: event, observer: sky.location, timezone: sky.timezone)
                            .gridCellColumns(2)
                    }
                }
                GridRow {
                    SkyGridRow(title: "Daily", symbolName: "circle") {
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

    struct WeatherItems: View {
        let weather: Weather?
        var body: some View {
            if let weather {
                GridRow {
                    SkyGridRow(Cloud.self, weather: weather)
                    SkyGridRow(Wind.self, weather: weather)
                }
                GridRow {
                    SkyGridRow(Precipitation.self, weather: weather)
                    SkyGridRow(Temperature.self, weather: weather)
                }
                GridRow {
                    SkyGridRow(Visibility.self, weather: weather)
                    SkyGridRow(Percent.self, weather: weather)
                }
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
