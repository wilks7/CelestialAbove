//
//  ForecastCell.swift
//  CelestialAbove
//
//  Created by Michael Wilkowski on 8/26/23.
//

import SwiftUI
import WeatherKit

struct ForecastCell<W:WeatherProtocol>: View {
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

extension ForecastCell {
    
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
        default:
            formatter.dateFormat = "ha"
        }
        return formatter.string(from: weather.date)
    }
}


#Preview {
    ForecastCell(weather: MockData.forecast.first!, sunEvents: nil, alignment: .horizontal)

}
#Preview {
    ForecastCell(weather: MockData.forecast.first!, sunEvents: nil, alignment: .vertical)
}

