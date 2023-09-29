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
    
    @ViewBuilder
    var vertical: some View {
        Text(title)
            .font(.title3)
            .bold()
            .foregroundStyle(.white)
            .gridColumnAlignment(.leading)
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
            GeometryReader { proxy in
                Capsule()
                    .fill(LinearGradient(colors: [.white, .blue, .indigo], startPoint: .leading, endPoint: .trailing))
                    .frame(width: weather.percent * proxy.size.width)
            }
        }
        .frame(width: 140, height: 4)
        Spacer()
        Text(weather.percent, format: .percent)
//        Text(weather.percent.percentString ?? "0")
            .font(.system(size: 16, weight: .bold))
            .padding(.top, 5)
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
            Text(weather.percent, format: .percent)
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

protocol WeatherProtocol: Codable, Equatable, Identifiable {
    var date: Date {get}
    var percent: Double {get}
    var condition: WeatherCondition {get}
    var symbolName: String {get}
}

extension WeatherProtocol { public var id: Date { date } }

extension DayWeather: WeatherProtocol {
    var percent: Double { precipitationChance }
}
extension HourWeather: WeatherProtocol {
    var percent: Double { cloudCover }
}

extension CurrentWeather: WeatherProtocol {
    var percent: Double { (cloudCover + humidity) / 2 }
}



#Preview {
    ForecastCell(weather: MockData.forecast.first!, sunEvents: nil, alignment: .horizontal)

}
#Preview {
    ForecastCell(weather: MockData.forecast.first!, sunEvents: nil, alignment: .vertical)
}

