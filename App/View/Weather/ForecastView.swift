//
//  WeatherView.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 5/12/23.
//

import SwiftUI
import WeatherKit

struct ForecastView<W:WeatherProtocol>: View {
    let forecast: [W]?
        
    let timezone: TimeZone?
    var sunEvents: SunEvents? = nil
    var alignment: Axis.Set = .horizontal
    var items: Int = 0
    
    var forecastArray: [W] {
        guard let forecast else {return []}
        guard items != 0 else {return forecast}
        return Array(forecast.prefix(items))
    }
    
    var title: String {
        switch forecast {
        case is [DayWeather]:
            return "Daily"
        case is [HourWeather]:
            return "Hourly"
        case is [MinuteWeather]:
            return "Minutely"
        default: return "Forecast"
        }
    }

    var body: some View {
        if !forecastArray.isEmpty {
            VStack {
                #warning("Add Header")
//                ItemHeader(title: title, symbolName: "cloud")
                ScrollView(alignment, showsIndicators: false) {
                    if alignment == .horizontal {
                        LazyHStack(spacing: 10){
                            ForEach(forecastArray){ weather in
                                ForecastCell(weather: weather, sunEvents: sunEvents, alignment: alignment)
                            }
                        }
                    } else {
                        Grid {
                            ForEach(forecastArray){ weather in
                                GridRow {
//                                    Text("Title")
//                                        .font(.title3)
//                                        .bold()
//                                        .foregroundStyle(.white)
//                                    Image(systemName: "cloud")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .font(.title2)
//                                        .symbolVariant(.fill)
//                                        .symbolRenderingMode(.multicolor)
//                                        .frame(height:30)
                                    ForecastCell(weather: weather, sunEvents: sunEvents, alignment: alignment)
                                }
                            }
                        }
//                        VStack(alignment: .leading, spacing: 5){
//
//                            }
//                        }
                    }
                }
            }
//            .padding()
//            .transparent()
        }
    }
}

#Preview {
    ForecastView(forecast: MockData.forecast, timezone: MockData.timezoneNY)
        .frame(height: 150)
}
