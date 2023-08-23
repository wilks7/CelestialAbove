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
                ItemHeader(title: title, symbolName: "cloud")
                ScrollView(alignment) {
                    if alignment == .horizontal {
                        LazyHStack(spacing: 10){
                            ForEach(forecastArray){ weather in
                                Cell(weather: weather, sunEvents: sunEvents, alignment: alignment)
                            }
                        }
                    } else {
                        VStack(alignment: .leading, spacing: 5){
                            ForEach(forecastArray){ weather in
                                Cell(weather: weather, sunEvents: sunEvents, alignment: alignment)
                            }
                        }
                    }
                }
            }
            .padding()
            .transparent()
        }
    }
}

extension ForecastView {
    struct Cell<W:WeatherProtocol>: View {
        let weather: W
        let sunEvents: SunEvents?
        let alignment: Axis.Set
        
        var body: some View {
            if alignment == .horizontal {
                horizontal
            } else {
                vertical
            }
        }
        
        var vertical: some View {
            HStack(spacing: 10){
                Text(title)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: weather.symbolName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.title2)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.multicolor)
                    .frame(height:30)
                Spacer()
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.tertiary)
                        .foregroundStyle(.white)
                    GeometryReader{proxy in
                        Capsule()
                            .fill(.linearGradient(.init(colors: [.white, .blue, .indigo]), startPoint: .leading, endPoint: .trailing))
                            .frame(width: (weather.percent / 140) * proxy.size.width)
                    }
                }
                .frame(width: 140, height: 4)
                Spacer()
                Text(Int(weather.percent).description)
                    .font(.system(size: 16, weight: .bold))
                    .padding(.top, 5)
            }
            .foregroundStyle(.white)
        }
        
        var horizontal: some View {
            VStack(spacing: 10){
                Text(title)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 16)
                Image(systemName: weather.symbolName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.title2)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.multicolor)
                    .frame(height:30)
                Text(Int(weather.percent).description)
                    .font(.system(size: 16, weight: .bold))
                    .padding(.top, 5)
            }
            .foregroundStyle(.white)
        }
    }
}

extension ForecastView.Cell {
    
    var title: String {
        let formatter = DateFormatter()
        switch weather {
        case is DayWeather:
            if Calendar.current.isDateInToday(weather.date) {
                return "Today"
            }
            formatter.dateFormat = "E"
        case is HourWeather:
            if Calendar.current.isDateInHour(weather.date) {
                return "Now"
            }
            formatter.dateFormat = "ha"
        case is MinuteWeather:
            if Calendar.current.isDateInMinute(weather.date) {
                return "Now"
            }
            formatter.dateFormat = "mm"
        default: break
        }
        return formatter.string(from: weather.date)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(forecast: MockData.forecast, timezone: MockData.timezoneNY)

    }
}
