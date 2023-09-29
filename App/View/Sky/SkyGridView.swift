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
                GridRow {
                    SunMoonView(location: sky.location,
                                timezone: sky.timezone,
                                sunEvents: weather?.today?.sun,
                                moonEvents: weather?.today?.moon
                    )
                }
                GridRow {
                    SkyGridCell(title: "Hourly", symbolName: "circle") {
                        ForecastView(forecast: weather?.hourly, timezone: sky.timezone, alignment: .horizontal)

                    } sheet: {
                        
                    }
                    .gridCellColumns(2)

                }
                ForEach(events) { event in
                    GridRow {
                        SkyGridCell(title: event.title, symbolName: "circle", viewType: .chart) {
                            
                        } chart: {
                            CelestialChart(chartPoints: event.points)
                        } sheet: {
                            Text("Detail")
                        }
                            .gridCellColumns(2)
                    }
                }
                GridRow {
                    SkyGridCell(title: "Daily", symbolName: "circle") {
                        ForecastView(forecast: weather?.daily, timezone: sky.timezone, alignment: .vertical)

                    } sheet: {
                        
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
