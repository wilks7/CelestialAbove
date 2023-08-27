//
//  SkyGridView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/26/23.
//

import SwiftUI
import WeatherKit

struct SkyGridView: View {
    let title: String
    let events: [CelestialEvents]
    let timezone: TimeZone
    let weather: Weather?
    let sunEvents: SunEvents?
    let moonEvents: MoonEvents?
    let color: SwiftUI.Color
    
    @State var mapImage: UIImage?
    @State var mapTapped = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            header
            Grid {
                GridRow {
                    SunMoonView(sunEvents: sunEvents, moonEvents: moonEvents)
                }
                GridRow {
                    ForecastView(forecast: weather?.hourly, timezone: timezone)
                }
                .gridCellColumns(2)
                celestialCharts
                GridRow {
                    ForecastView(forecast: weather?.daily, timezone: timezone, alignment: .vertical)
                }
                .gridCellColumns(2)
                #if !os(watchOS)
                GridRow {
                    SkyGridCell(title: "Light Pollution", symbolName: "map") {
                        LightPollutionView(location: MockData.locationNY)
                    }
                }
                .gridCellColumns(2)
                #endif
                weatherItems
            }
            .padding()
        }
        .background(color)
    }
    
    var header: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
            Text("90%")
                .font(.system(size: 82))
            
        }
    }
    
    var celestialCharts: some View {
        ForEach(events) { event in
            GridRow {
                SkyGridCell(title: event.title, symbolName: event.symbolName) {
                    CelestialChart(events: event, sunrise: sunEvents?.sunrise, sunset: sunEvents?.sunset)
                }
            }
            .gridCellColumns(2)
        }
    }
    
    @ViewBuilder
    var weatherItems: some View {
        if let hour = weather?.hour, let day = weather?.today, let hourly = weather?.hourly {
            GridRow {
                SkyGridCell(Cloud.self, hour: hour, hourly, day: day)
                SkyGridCell(Wind.self, hour: hour, hourly, day: day)
            }
            GridRow {
                SkyGridCell(Temperature.self, hour: hour, hourly, day: day)
                SkyGridCell(Precipitation.self, hour: hour, hourly, day: day)
            }
            GridRow {
                SkyGridCell(Visibility.self, hour: hour, hourly, day: day)
            }
        }
    }

}

extension SkyGridView {
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
        return SkyGridView(sky: sky)
    }
}
#Preview {
    SkyGridView(title: "Title",
            events: MockData.events,
            timezone: MockData.timezoneNY,
            weather: nil,
            sunEvents: MockData.sunEvents,
            moonEvents: MockData.moonEvents,
            color: .blue
    )
}
